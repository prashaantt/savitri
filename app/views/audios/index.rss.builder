xml.instruct! :xml, version: "1.0" 
xml.rss version: "2.0" do
  unless @audios.first.nil?
    medium = @audios.first.medium
    xml.channel do
      xml.title medium.title
      xml.link request.protocol + request.host_with_port + medium_audios_path
      xml.description medium.subtitle
      xml.language medium.language
      xml.pubDate @audios.first.updated_at.to_s(:rfc822)
      xml.itunes :subtitle, medium.subtitle
      xml.itunes :author, medium.user.name
      xml.itunes :keywords, "sri aurobindo, aurobindo, the mother, mother, mirra, alfassa, savitri, integral yoga, yoga, supermind, supramental, spirituality"
      xml.itunes :image, medium.image_url
      xml.itunes :owner do
        xml.itunes :name, medium.user.name
        xml.itunes :email, medium.user.email
      end
      xml.itunes :category, :text => "Religion & Spirituality" do
        xml.itunes :category, :text => "Spirituality"
      end
      xml.itunes :category, :text => "Arts" do
        xml.itunes :category, :text => "Literature"
      end
      @audios.each do |audio|
        xml.item do
          xml.title audio.title
          xml.pubDate audio.updated_at.to_s(:rfc822)
          xml.itunes :summary, audio.summary
          if audio.author?
            xml.itunes :author, audio.author
          end
          xml.guid({:isPermaLink => "true"}, request.protocol + request.host_with_port + medium_audios_path + "/" + audio.url)
          xml.enclosure :url => audio.audio_url, :type => "audio/mp3"
        end
      end
    end
  end
end
