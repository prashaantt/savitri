Edition.create(name: 'First', year: 1950)
Edition.create(name: 'Revised', year: 1993)
Book.update_all(edition_id:1)

Book.find_each do |book|
p book
Book.create(no: book.no, name:book.name,edition_id:2)
end

Canto.find_each do |canto|
p canto
book_id = Book.where(edition_id:2).where(name:canto.book.name).first.id
Canto.create(no: canto.no, title:canto.title,description: canto.description,book_id:book_id)
end

Section.find_each do |section|
p section
canto_id = Edition.last.cantos.where(title:section.canto.title).first.id
Section.create(no: section.no, name:"", runningno: section.runningno, canto_id:canto_id)
end

Stanza.find_each do |stanza|
p stanza
section_id = Edition.last.sections.where(title:stanza.canto.title).first.id
Stanza.create(no: stanza.no, runningno: stanza.runningno, section_id:section_id)
end