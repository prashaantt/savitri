namespace :add_new_edition do
  desc "Add Books for revised_edition"
  task :add_books => :environment do
    # Add editions and update existing books with first edition
    Edition.create(name: 'First', year: 1950)
    Edition.create(name: 'Revised', year: 1993)
    Book.update_all(edition_id:1)
    # Create new books for revised edition from first edition
    Book.find_each do |book|
      Book.create(no: book.no, name:book.name,edition_id:2)
    end
    # Create new cantos for revised edition from first edition
    Canto.find_each do |canto|
      book_id = Book.where(edition_id:2).where(name:canto.book.name).first.id
      Canto.create(no: canto.no, title:canto.title,description: canto.description,book_id:book_id)
    end
    #sections, stanzas and lines are changed in revised edition
  end

  desc "Add revised edition"
  task :revised_edition => :environment do
    # Single text file of revised edition is manually cantowise splitted.
    # Files should be named canto_1.txt canto_2.txt... canto_49.txt
    # Read each file and paragraphwise split each file.
    # Every paragraph is a new section.
    # Every stanza ends where line is ended with .(dot),?(question mark) or !(exclamation mark)
    # Every new line is a line in lines table.
    p "Enter cantos folder path e.g. /home/ec2-user/cantos"
    cantos_folder_path = STDIN.gets.chomp
    section_no = 0
    line_no = 0
    stanza_no = 0
    cantos = Edition.find(2).cantos.order(:book_id)
    (1..49).each do |n|
      canto = cantos[n-1]
      p "#{cantos_folder_path}/canto_#{n}.txt"
      savitri_file = File.read("#{cantos_folder_path}/canto_#{n}.txt", :encoding => 'UTF')
      sections = savitri_file.split(/^\s*$/)
      sections.each_with_index do |section,index|
        lines = section.split(/\r?\n/)
        lines.reject! { |c| c.strip.empty? }
        section_no += 1
        p "-------Section #{section_no}"
        section_obj = canto.sections.create(no:section_no, runningno: (index + 1))
        stanza_no += 1
        runningno = 1
        stanza = section_obj.stanzas.create(no:stanza_no, runningno: runningno)
        lines.each do |line|
          line_no += 1
          ll = stanza.lines.create(no:line_no,line: line.strip)
          if (line.match(/[\.\?\!]$/) && (line != lines.last))
            stanza_no += 1
            runningno += 1
            stanza = section_obj.stanzas.create(no:stanza_no, runningno: runningno)
          end
        end
      end
    end
  end
end
