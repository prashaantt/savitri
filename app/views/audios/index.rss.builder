xml.instruct! :xml, version: "1.0" 
xml.rss "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd", "xmlns:media" => "http://search.yahoo.com/mrss/", "xmlns:atom" => "http://www.w3.org/2005/Atom", :version => "2.0" do
  unless @audios.first.nil?
    medium = @audios.first.medium
    feed_url = request.protocol + request.host_with_port + medium_audios_path
    xml.channel do
      xml.tag! "atom:link", :rel => "self", :type => "application/rss+xml", :href => feed_url + ".rss"
      xml.title medium.title
      xml.link feed_url
      xml.description medium.summary
      if medium.language?
        xml.language medium.language
      else
        xml.language "en"
      end
      xml.pubDate @audios.first.updated_at.to_s(:rfc822)
      xml.itunes :summary, medium.summary
      xml.itunes :subtitle, medium.subtitle
      xml.itunes :author, medium.user.name
      xml.itunes :keywords, "sri aurobindo, aurobindo, the mother, mother, mirra, alfassa, savitri, integral yoga, yoga, supermind, supramental, spirituality"
      xml.itunes :image, :href => medium.image_url
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
      if medium.explicit?
        xml.itunes :explicit, medium.explicit
      else
        xml.itunes :explicit, "no"
      end
      @audios.each do |audio|
        xml.item do
          xml.title audio.title
          xml.pubDate audio.updated_at.to_s(:rfc822)
          xml.itunes :subtitle, audio.summary
          xml.itunes :summary, audio.summary
          if audio.author?
            xml.itunes :author, audio.author
          else
            xml.itunes :author, medium.user.name
          end
          xml.itunes :image, :href => medium.image_url
          xml.guid({:isPermaLink => "true"}, feed_url + "/" + audio.url)
          xml.enclosure :url => audio.audio_url, :type => "audio/mpeg", :length => audio.file_size
          xml.itunes :duration, audio.duration["total"]
          if audio.explicit?
            xml.itunes :explicit, audio.explicit
          else
            xml.itunes :explicit, "no"
          end
        end
      end
    end
  end
end
