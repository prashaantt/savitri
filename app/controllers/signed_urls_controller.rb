class SignedUrlsController < ApplicationController
  def index
    if Rails.env.production?
      @bucket="savitri-in-uploads"
    else
      @bucket="savitri-in-devuploads"
    end
    
    render json: {
    	policy: s3_upload_policy_document,
    	signature: s3_upload_signature,
    	key: "uploads/music/#{SecureRandom.uuid}/#{params[:doc][:title]}",
    	success_action_redirect: "/"
    }
  end

  private
  # generate the policy document that amazon is expecting.
  def s3_upload_policy_document
    Base64.encode64(
      {
        expiration: 30.minutes.from_now.utc.strftime('%Y-%m-%dT%H:%M:%S.000Z'),
        conditions: [
          { bucket: @bucket},
          #{ bucket: ENV['S3_BUCKET'] },
          { acl: 'public-read' },
          ["starts-with", "$key", "uploads/music/"],
          { success_action_status: '201' }
        ]
      }.to_json
    ).gsub(/\n|\r/, '')
  end

  # sign our request by Base64 encoding the policy document.
  def s3_upload_signature
    Base64.encode64(
      OpenSSL::HMAC.digest(
        OpenSSL::Digest::Digest.new('sha1'),
        "5k2v6pS1U+S9t1iZ4MrD1mGfbpP6qip+1+QqtIf1",
        #ENV['AWS_SECRET_KEY_ID'],
        s3_upload_policy_document
      )
    ).gsub(/\n/, '')
  end
end
