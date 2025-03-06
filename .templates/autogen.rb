# frozen_string_literal: true

require 'colorize'
require 'erb'
require 'fileutils'
require 'tty-prompt'

def main
  display_main_menu()
  get_type_of_doc()
end

def display_main_menu
  menu = <<-'MENU'


  /======================================================================\
  || _  _ _____ __  __ _       ___ ___ _  _ ___ ___    _ _____ ___  ___ ||
  ||| || |_   _|  \/  | |     / __| __| \| | __| _ \  /_\_   _/ _ \| _ \||
  ||| __ | | | | |\/| | |__  | (_ | _|| .` | _||   / / _ \| || (_) |   /||
  |||_||_|_|_| |_|  |_|____|  \___|___|_|\_|___|_|_\/_/ \_\_| \___/|_|_\||
  ||__ __/  \ /  \ / |                                                  ||
  ||\ V / () | () || |                                                  ||
  || \_/ \__(_)__(_)_|                                                  ||
  \======================================================================/


  MENU

  puts menu
end

def get_type_of_doc
  prompt = TTY::Prompt.new

  options = [
    { name: 'Year page', value: -> { make_year_page(get_descriptors('year')) } },
    { name: 'CTF page', value: -> { make_ctf_page(get_descriptors('ctf')) } },
    { name: 'Category page', value: -> { make_category_page(get_descriptors('category')) } },
    { name: 'Challenge page', value: -> { make_challenge_page(get_descriptors('challenge')) } }
  ]
  prompt.select('Please select the type of document', options, cycle: true)
end

def make_year_page(html_descriptors, recursive = false)
  file_descriptors = html_descriptors.transform_values do |value|
    value.downcase.gsub(' ', '-').gsub(%r{[!@#$%^&*()_+`~={}|\[\]\\:";'<>?,./]}, '')
  end
  html_file_path = "/home/slavetomints/repos/websites/writeups/writeups/#{file_descriptors['year']}/#{file_descriptors['year']}.html"

  if File.file?(html_file_path)
    puts "File already exists at #{html_file_path}, will not overwrite".colorize(:red)
  else
    unless File.directory?("/home/slavetomints/repos/websites/writeups/writeups/#{file_descriptors['year']}")
      FileUtils.mkdir_p("/home/slavetomints/repos/websites/writeups/writeups/#{file_descriptors['year']}")
    end

    template = File.read('year.rhtml')
    erb_template = ERB.new template
    File.open(html_file_path, 'w') do |file|
      year_file = erb_template.result(binding)
      file.puts year_file
      puts 'File made!'.colorize(:green)
    end
  end

  unless recursive
    puts "For writeups.html"
    list_item = <<-'LIST_ITEM' 
    <li><a href="https://slavetomints.github.io/writeups/writeups/#{file_descriptors['year']}/#{file_descriptors['year']}.html"> #{html_descriptors['year']}
      <ul>
      </ul>
    </li>
    LIST_ITEM
    puts list_item
  end

end

def make_ctf_page(html_descriptors, recursive = false)
  file_descriptors = html_descriptors.transform_values do |value|
    value.downcase.gsub(' ', '-').gsub(%r{[!@#$%^&*()_+`~={}|\[\]\\:";'<>?,./]}, '')
  end
  html_file_path = "/home/slavetomints/repos/websites/writeups/writeups/#{file_descriptors['year']}/#{file_descriptors['ctf']}/#{file_descriptors['ctf']}.html"

  if File.file?(html_file_path)
    puts "File already exists at #{html_file_path}, will not overwrite".colorize(:red)
  else

    unless File.directory?("/home/slavetomints/repos/websites/writeups/writeups/#{file_descriptors['year']}/#{file_descriptors['ctf']}")
      FileUtils.mkdir_p("/home/slavetomints/repos/websites/writeups/writeups/#{file_descriptors['year']}/#{file_descriptors['ctf']}")
    end

    template = File.read('ctf.rhtml')
    erb_template = ERB.new template
    File.open(html_file_path, 'w') do |file|
      ctf_file = erb_template.result(binding)
      file.puts ctf_file
      puts 'File made!'.colorize(:green)
    end
  end

  unless recursive
    puts "For #{file_descriptors['year']}.html"
    list_item = <<-'LIST_ITEM' 
    <li><a href="https://slavetomints.github.io/writeups/writeups/#{file_descriptors['year']}/#{file_descriptors['ctf']}/#{file_descriptors['ctf']}.html"> #{html_descriptors['ctf']}
      <ul>
      </ul>
    </li>
    LIST_ITEM
    puts list_item
  end

  make_year_page(html_descriptors, true)
end

def make_category_page(html_descriptors, recursive = false)
  file_descriptors = html_descriptors.transform_values do |value|
    value.downcase.gsub(' ', '-').gsub(%r{[!@#$%^&*()_+`~={}|\[\]\\:";'<>?,./]}, '')
  end
  html_file_path = "/home/slavetomints/repos/websites/writeups/writeups/#{file_descriptors['year']}/#{file_descriptors['ctf']}/#{file_descriptors['category']}/#{file_descriptors['category']}.html"

  if File.file?(html_file_path)
    puts "File already exists at #{html_file_path}, will not overwrite".colorize(:red)
  else

    unless File.directory?("/home/slavetomints/repos/websites/writeups/writeups/#{file_descriptors['year']}/#{file_descriptors['ctf']}/#{file_descriptors['category']}")
      FileUtils.mkdir_p("/home/slavetomints/repos/websites/writeups/writeups/#{file_descriptors['year']}/#{file_descriptors['ctf']}/#{file_descriptors['category']}")
    end

    template = File.read('category.rhtml')
    erb_template = ERB.new template
    File.open(html_file_path, 'w') do |file|
      category_file = erb_template.result(binding)
      file.puts category_file
      puts 'File made!'.colorize(:green)
    end
  end
  unless recursive
    puts "For #{file_descriptors['ctf']}.html"
    list_item = <<-'LIST_ITEM' 
    <li><a href="https://slavetomints.github.io/writeups/writeups/#{file_descriptors['year']}/#{file_descriptors['ctf']}/#{file_descriptors['category']}/#{file_descriptors['category']}.html"> #{html_descriptors['category']}
      <ul>
      </ul>
    </li>
    LIST_ITEM
    puts list_item
  end
  make_ctf_page(html_descriptors, true)
end

def make_challenge_page(html_descriptors, *recursive)
  file_descriptors = html_descriptors.transform_values do |value|
    value.downcase.gsub(' ', '-').gsub(%r{[!@#$%^&*()_+`~={}|\[\]\\:";'<>?,./]}, '')
  end

  html_file_path = "/home/slavetomints/repos/websites/writeups/writeups/#{file_descriptors['year']}/#{file_descriptors['ctf']}/#{file_descriptors['category']}/#{file_descriptors['challenge']}/#{file_descriptors['challenge']}.html"

  if File.file?(html_file_path)
    puts "File already exists at #{html_file_path}, will not overwrite".colorize(:red)
  else
    html_directory_path = "/home/slavetomints/repos/websites/writeups/writeups/#{file_descriptors['year']}/#{file_descriptors['ctf']}/#{file_descriptors['category']}/#{file_descriptors['challenge']}"
    markdown_path = "/home/slavetomints/repos/websites/slavetomints.github.io/markdown/writeups/#{file_descriptors['year']}/#{file_descriptors['ctf']}/#{file_descriptors['category']}/#{file_descriptors['challenge']}.md"
    puts markdown_path

    FileUtils.mkdir_p(html_directory_path) unless File.directory?(html_directory_path)

    if File.exist?(markdown_path)
      markdown = File.read(markdown_path)
      puts 'Markdown read!'.colorize(:green)

      num_of_images = markdown.scan(/!\[.*?\]\(.*?\)/).size
      puts "#{num_of_images} Image#{'s' unless num_of_images == 1} Detected!".colorize(:red)
    else
      puts 'Markdown not found'.colorize(:yellow)
      markdown = <<~MARKDOWN
        # Change Me
        ## Change me
        ### Change ME
        > Change ME
        - Change me
          - change me
        - change me
      MARKDOWN
    end

    template = File.read('challenge.rhtml')
    erb_template = ERB.new template
    File.open(html_file_path, 'w') do |file|
      challenge_file = erb_template.result(binding)
      file.puts challenge_file
      puts 'File made!'.colorize(:green)
    end
  end
  list_item = <<-'LIST_ITEM' 
  <li><a href="https://slavetomints.github.io/writeups/writeups/#{file_descriptors['year']}/#{file_descriptors['ctf']}/#{file_descriptors['category']}/#{file_descriptors['challenge']}/#{file_descriptors['challenge']}.html"> #{html_descriptors['challenge']}
    <ul>
    </ul>
  </li>
  LIST_ITEM
  puts list_item
  make_category_page(html_descriptors, true)
end

def get_descriptors(type)
  descriptors = {}
  case type
  when 'year'
    puts "\nWhat year is it? write 'Training' if its for training"
    descriptors['year'] = gets.chomp

    puts "\nPlease review your selection, if it is wrong then enter 'wrong'"
    puts descriptors
    get_descriptors(type) if gets.chomp == 'wrong'

  when 'ctf'
    puts "\nWhat year is it? write 'Training' if its for training"
    descriptors['year'] = gets.chomp

    puts "\nWhat is the name of the CTF?"
    descriptors['ctf'] = gets.chomp

    puts "\nPlease review your selection, if it is wrong then enter 'wrong'"
    puts descriptors
    get_descriptors(type) if gets.chomp.downcase == 'wrong'

  when 'category'
    puts "\nWhat year is it? write 'Training' if its for training"
    descriptors['year'] = gets.chomp

    puts "\nWhat is the name of the CTF?"
    descriptors['ctf'] = gets.chomp

    puts "\nWhat is the name of the category"
    descriptors['category'] = gets.chomp

    puts "\nPlease review your selection, if it is wrong then enter 'wrong'"
    puts descriptors
    get_descriptors(type) if gets.chomp == 'wrong'

  when 'challenge'
    puts "\nWhat year is it? write 'Training' if its for training"
    descriptors['year'] = gets.chomp

    puts "\nWhat is the name of the CTF?"
    descriptors['ctf'] = gets.chomp

    puts "\nWhat is the name of the category"
    descriptors['category'] = gets.chomp

    puts "\nWhat is the name of the challenge"
    descriptors['challenge'] = gets.chomp

    puts "\nPlease review your selection, if it is wrong then enter 'wrong'"
    puts descriptors
    get_descriptors(type) if gets.chomp == 'wrong'
  end
  descriptors
end

main()
