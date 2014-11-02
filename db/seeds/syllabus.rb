require 'poppler'

SYLLABUSES_PATH = "#{Rails.root}/db/seeds/syllabus"

def get_enum_key(department)
  case department
  when 'I' then :information
  when 'E' then :electronics
  when 'M' then :mechanical
  when 'S' then :system
  when 'C' then :chemistry
  when 'AEI' then :advanced_ei
  when 'AMS' then :advanced_ms
  when 'AC' then :advanced_c
  else nil
  end
end

def parse(path, attrs = {})
  begin
    pdf = Poppler::Document.new(path)
  rescue
    raise "Error: PDF was not found."
  end

  begin
    str = pdf[0].get_text
    elements = str.split("\n")
    raise if elements.length < 2
  rescue
    raise "Error: 1st page was invalid."
  end

  def elements.matched(key, regexp, opt = {})
    index = opt[:index] || 0
    range = opt[:range] || (0..self.length)
    matched_element = self[range].find{|element| element =~ regexp}
    matched_element.match(regexp)[index] rescue nil
  end

  # 講義名
  attrs[:name] = elements[2]
  attrs[:english_name] = elements.matched(:english_name, /^[\(（](.+)[）\)]$/, index: 1, range: 0..10)

  # 単位期間
  attrs[:term] = elements.matched(:credit_term, /前期|後期|通年/, range: 1..11)

  # 単位数
  attrs[:credit_num] = elements.matched(:credit_num, /([0-9０-９]{1,2})\s?(学修)?単位/, index: 1, range: 1..11)

  # 単位必修属性
  attrs[:credit_requirement] = elements.matched(:credit_requirement, /選択|必修/, range: 1..11)

  # 各特徴
  first_text_column = elements.find{|element| element =~ /講[義座]の目[標的]/}
  first_text_column_index = elements.index(first_text_column)
  elements_length = elements.length
  title_buffer, body_buffer = '', ''

  begin
    attrs[:features_attributes] = []
    elements[first_text_column_index..elements_length].each do |element|
      if key = element.match(/^[\[〔](.+)[\]〕]$/)
        attrs[:features_attributes] << {name: title_buffer, content: body_buffer} if body_buffer.present?
        title_buffer = key[1]
        body_buffer = ''
      else
        body_buffer += "#{element}\n"
      end
    end
  rescue
  end

  return attrs
end

years = Dir.entries(SYLLABUSES_PATH).select{|name| name =~ /^\d{4}$/}
years.each do |year|
  class_names = Dir.entries("#{SYLLABUSES_PATH}/#{year}").select{|name| name =~ /^\d[A-Z]{1,3}$/}
  class_names.each do |class_name|
    pdfs = Dir.entries("#{SYLLABUSES_PATH}/#{year}/#{class_name}").select{|name| name =~ /\.pdf$/}
    pdfs.each do |pdf|
      path = "#{SYLLABUSES_PATH}/#{year}/#{class_name}/#{pdf}"
      matched_class_name = class_name.match(/^(\d)([A-Z]{1,3})$/)
      grade = matched_class_name[1]
      department = get_enum_key(matched_class_name[2])
      begin
        attrs = parse(path, year: year, grade: grade, department: department)
        item = Item.new(attrs)
        unless item.save
          puts "Fail: saving #{year}/#{class_name}/#{pdf}"
        end
      rescue
        puts "Error: #{year}/#{class_name}/#{pdf} attrs: #{attrs}"
      end
    end
  end
end
