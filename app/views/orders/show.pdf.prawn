require 'prawn/table'
logo_path = Rails.root.join('app/assets/images/logo-big.png')
initial_y = pdf.cursor
initialmove_y = 5
address_x = 35
invoice_header_x = 325
lineheight_y = 12
font_size = 9

pdf.repeat :all do
  pdf.move_down initialmove_y

  # Add the font style and size
  pdf.font "Helvetica"
  pdf.font_size font_size

  #start with StudySquare
  pdf.text_box "StudySquare", :at => [address_x,  pdf.cursor]
  pdf.move_down lineheight_y
  pdf.text_box "Vechtstraat 145-1", :at => [address_x,  pdf.cursor]
  pdf.move_down lineheight_y
  pdf.text_box "1079 JG Amsterdam", :at => [address_x,  pdf.cursor]
  pdf.move_down lineheight_y

  last_measured_y = pdf.cursor
  pdf.move_cursor_to pdf.bounds.height

  pdf.image logo_path, :width => 160, :position => :right

  pdf.move_cursor_to last_measured_y

  # client address
  pdf.move_down 65
  last_measured_y = pdf.cursor

  pdf.text_box @user.name, :at => [address_x,  pdf.cursor]
  pdf.move_down lineheight_y
  pdf.text_box [@user.address_street, @user.address_number].join(' '), :at => [address_x,  pdf.cursor]
  pdf.move_down lineheight_y
  pdf.text_box [@user.address_zip, @user.address_residence].join(' '), :at => [address_x,  pdf.cursor]

  pdf.move_cursor_to last_measured_y
end

invoice_header_data = [
  ["Factuur #", @order.id],
  ["Factuurdatum", l(@order.created_at, format: :long_date)],
  ["Totaalbedrag", number_to_currency(@order.total)]
]

pdf.table(invoice_header_data, :position => invoice_header_x, :width => 215) do
  style(row(0..1).columns(0..1), :padding => [1, 5, 1, 5], :borders => [])
  style(row(2), :background_color => 'e9e9e9', :border_color => 'dddddd', :font_style => :bold)
  style(column(1), :align => :right)
  style(row(2).columns(0), :borders => [:top, :left, :bottom])
  style(row(2).columns(1), :borders => [:top, :right, :bottom])
end

pdf.move_down 45

invoice_services_data = [
  ["Inschrijving#", "Cursus", "Prijs"],
  [" ", " ", " "]
]

(@registrations).each do |registration|
  invoice_services_data.insert 1, [
    registration.id,
    registration.course.description,
    number_to_currency(registration.price)
  ]
end

pdf.table(invoice_services_data, :width => pdf.bounds.width) do
  style(row(1..-1).columns(0..-1), :padding => [4, 5, 4, 5], :borders => [:bottom], :border_color => 'dddddd')
  style(row(0), :background_color => 'e9e9e9', :border_color => 'dddddd', :font_style => :bold)
  style(row(0).columns(0..-1), :borders => [:top, :bottom])
  style(row(0).columns(0), :borders => [:top, :left, :bottom])
  style(row(0).columns(-1), :borders => [:top, :right, :bottom])
  style(row(-1), :border_width => 2)
  style(column(2..-1), :align => :right)
  style(columns(0), :width => 75)
end

pdf.move_down 1

invoice_services_totals_data = [
  ["Totaal", number_to_currency(@order.total)],
  #["Voldaan", @order.payed? ? number_to_currency(@order.total) : number_to_currency(0)],
  #["Verschuldigd", @order.payed? ? number_to_currency(0) : number_to_currency(@order.total)]
]

pdf.table(invoice_services_totals_data, :position => invoice_header_x, :width => 215) do
  style(column(1), :align => :right)
  style(row(0..3).columns(0..1), :padding => [2, 5, 2, 5], :borders => [])

  style(row(0), :font_style => :bold) # Subtotaal
  style(row(2), :font_style => :bold) # Totaal

  style(row(4), :background_color => 'e9e9e9', :border_color => 'dddddd', :font_style => :bold)
end

pdf.repeat :all do
  pdf.bounding_box [pdf.bounds.left, pdf.bounds.bottom + 10], :width  => pdf.bounds.width do
    pdf.text "info@studysquare.nl - KvK: 51014750 - Rek.nr.: 1468.75.729 t.n.v. StudySquare, Rabobank", align: :center
  end
end

