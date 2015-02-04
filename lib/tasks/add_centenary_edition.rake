namespace :add_centenary_edition do
  desc "Read json and put into db"
  task :one => :environment do
    p "Enter Centenary ruby file's path e.g. /home/ec2-user/centenary/1.rb"
    centenary_file_path = STDIN.gets.chomp
    edition = Edition.create(name: 'Centenary', year: 1972)
    file = File.open("#{centenary_file_path}")
    data_hash = eval(file.read)
    data_hash[:books].first[:parts].each do |book|
      p book[:t]
      book_no = edition.books.maximum(:no).to_i + 1
      book_object = edition.books.create(no: book_no, name: book[:t])

      book[:chapters].each do |canto|
        canto_no = (book_object.cantos.maximum(:no).to_i + 1)
        canto_object = book_object.cantos.create(no: canto_no, title:canto[:t])
        section_runningno = 0

        canto[:txt].split('---').each do |section|
          section_no = edition.sections.maximum(:no).to_i + 1
          section_runningno += 1 #canto_object.sections.maximum(:no).to_i + 1
          p section_object = canto_object.sections.create(no: section_no, runningno: section_runningno)
          stanza_runningno = 0

          section.split(/\n\n/).each do |stanza|
            next if stanza.empty?
            stanza_runningno += 1
            stanza_no = edition.stanzas.maximum(:no).to_i + 1
            p stanza_object = section_object.stanzas.create(no: stanza_no, runningno: stanza_runningno)

            stanza.split(/\n/).each do |line|
              next if line.empty?
              line = line.gsub(/^&ensp;&ensp;&ensp;&ensp;/,'')
              line_no = edition.lines.maximum(:no).to_i + 1
              stanza_object.lines.create(no: line_no, line: line)
            end

          end

        end

      end

    end

  end
  desc "Read json and put into db"
  task :two => :environment do
    p "Enter Centenary ruby file's path e.g. /home/ec2-user/centenary/2.rb"
    centenary_file_path = STDIN.gets.chomp
    edition = Edition.last
    file = File.open("#{centenary_file_path}")
    data_hash = eval(file.read)
    [0,1].each do |b|
      data_hash[:books][b][:parts].each do |book|
        p book[:t]
        book_no = edition.books.maximum(:no).to_i + 1
        book_object = edition.books.create(no: book_no, name: book[:t])

        book[:chapters].each do |canto|
          canto_no = (book_object.cantos.maximum(:no).to_i + 1)
          canto_object = book_object.cantos.create(no: canto_no, title:canto[:t])
          section_runningno = 0

          canto[:txt].split('---').each do |section|
            section_no = edition.sections.maximum(:no).to_i + 1
            section_runningno += 1 #canto_object.sections.maximum(:no).to_i + 1
            p section_object = canto_object.sections.create(no: section_no, runningno: section_runningno)
            stanza_runningno = 0

            section.split(/\n\n/).each do |stanza|
              next if stanza.empty?
              stanza_runningno += 1
              stanza_no = edition.stanzas.maximum(:no).to_i + 1
              p stanza_object = section_object.stanzas.create(no: stanza_no, runningno: stanza_runningno)

              stanza.split(/\n/).each do |line|
                next if line.empty?
                line = line.gsub(/^&ensp;&ensp;&ensp;&ensp;/,'')
                line_no = edition.lines.maximum(:no).to_i + 1
                stanza_object.lines.create(no: line_no, line: line)
              end

            end

          end

        end

      end

    end

  end

end
