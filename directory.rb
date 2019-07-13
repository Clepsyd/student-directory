require 'csv'

@students = []

# Add elements to this list if more informations are required
@students_data_fields = [
  :name,
  :cohort,
  :age,
  :city,
  :hobbies
]

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Show a student's details"
  puts "4. Save the list to a CSV file"
  puts "5. Load the list from a CSV file"
  puts "9. Exit"
end

def print_header
  puts "The students of Villains Academy"
  puts "----------------"
end

def print_students_list()
  count = 0
  while count < @students.length
    student = @students[count]
    puts "* #{count + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    count += 1
  end
end

def print_footer()
  if @students.count > 1
    puts "Overall, we have #{@students.count} great students"
  else
    puts "Overall, we have #{@students.count} great student"
  end
  puts ""
end

def show_students
  print_header
  print_students_list
  print_footer
end

def show_one_student
  puts "Whose details do you need to see?"
  while true do
    name = gets.strip
    student = @students.select { |data| name == data[:name] }
    if student.empty?
      puts "Could not find this student, please try again:" 
    else
      break
    end
  end
  student.first.each { |k, v|
    puts "#{k}: #{v}"
  }
  puts ""
end

def input_menu
  puts "Add a student to the list? (y/n)"
  continue = STDIN.gets.strip
  while !["y", "n"].include?(continue)
    puts "Please answer 'y' or 'n'. Add a student to the list? (y/n)"
    continue = STDIN.gets.strip
    puts ""
  end
  return continue
end

def add_field(student)
  for element in @students_data_fields
    puts "Please enter the #{element.to_s} of the student"
    input = STDIN.gets.strip
    puts ""
    if input != ""
      student[element] = element == :cohort ? input.downcase.to_sym : input
    end
  end
end

def input_fields
  student = Hash.new("N/A")
  # Ask the user to fill information for every data_field
  add_field(student)
  @students << student
end

def input_students
  loop do
    break if input_menu == "n"
    input_fields
  end
end

def save_students
  puts "Please enter the name of your file (no extension - ex: .txt - required)"
  puts "Leave empty and press 'Enter' to create/overwrite default save file."
  filename = "#{STDIN.gets.strip}.csv"
  filename = filename == ".csv" ? "students.csv" : filename
  CSV.open(filename, "wb") do |file|
    @students.each { |student| file << student.values }
  end
  puts "#{@students.count} students saved in #{filename}"
  puts ""
end

def load_students(filename = "students.csv")
  @students.clear
  CSV.foreach(filename) { |line|
    student = Hash[@students_data_fields.zip line]
    @students << student
  }
  puts "File Loaded"
  puts ""
end

def menu_load
  puts "Please enter the name of the file you want to load:"
  loop do
    file = STDIN.gets.strip
    if File.exists?(file)
      load_students(file)
      break
    else
      puts "This file doesn't exist, please try again:"
    end
  end
end

def try_load_students
  filename = ARGV.first ? ARGV.first : "students.csv"
  if File.exist?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} entries from #{filename}."
    puts ""
  elsif filename == "students.csv"
    puts "No default file was found. Creating one now."
    system("touch students.csv")
  else
    puts "Sorry, #{filename} doesn't exist. Program shutting down."
    exit
  end
end

def interactive_menu
  loop do
    print_menu
    input = STDIN.gets.strip
    puts ""
    process(input)
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    show_one_student
  when "4"
    save_students
  when "5"
    menu_load
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end


#students = input_students

## let's put all students into an array
# students = [
  # {name: "Dr. Hannibal Lecter", cohort: :november},
  # {name: "Darth Vader", cohort: :november},
  # {name: "Nurse Ratched", cohort: :november},
  # {name: "Michael Corleone", cohort: :november},
  # {name: "Alex DeLarge", cohort: :november},
  # {name: "The Wicked Witch of the West", cohort: :november},
  # {name: "Terminator", cohort: :november},
  # {name: "Freddy Krueger", cohort: :november},
  # {name: "The Joker", cohort: :november},
  # {name: "Joffrey Baratheon", cohort: :november},
  # {name: "Norman Bates", cohort: :november}
  # ]

try_load_students
interactive_menu