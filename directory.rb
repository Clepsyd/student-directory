@students = []

# Add elements to this list if more informations are required
@students_data_fields = [
  :name,
  :cohort,
  :age,
  :city,
  :hobbies
]

def print_header
  puts "The students of Villains Academy"
  puts "----------------"
end

def print_students_list()
  count = 0
  while count < @students.length
    student = @students[count]
    puts "#{count + 1}. #{student[:name]} (#{student[:cohort]} cohort)".center(50)
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

def input_menu
  puts "Add a student to the list? (y/n)"
  continue = gets.chomp
  while !["y", "n"].include?(continue)
    puts "Please answer 'y' or 'n'. Add a student to the list? (y/n)"
    continue = gets.strip
    puts ""
  end
  return continue
end

def add_field(student)
  for element in @students_data_fields
    puts "Please enter the #{element.to_s} of the student"
    input = gets.strip
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

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = []
    @students_data_fields.each { |field| student_data << student[field] }
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
  puts "List of students saved in students.csv"
  puts ""
end

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
    student = Hash.new
    line.chomp.split(',').each_with_index { |val, index|
      field = @students_data_fields[index]
      student[field] = field == :cohort ? val.to_sym : val
    }
    @students << student
  end
  file.close
  puts "File loaded"
  puts ""
end

def interactive_menu
  loop do
    print_menu
    input = gets.chomp
    puts ""
    process(input)
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
  
interactive_menu