def print_header
  puts "The students of Villains Academy"
  puts "----------------"
end

def print(students)
  count = 0
  while count < students.length
    student = students[count]
    # if student[:name].start_with?("s", "S") && student[:name].size < 12
      puts "#{count + 1}. #{student[:name]} (#{student[:cohort]} cohort)".center(50)
    # end
    count += 1
  end
  
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

def input_students
  # Add elements to this list if more informations are required
  students_data_fields = [
    :name,
    :cohort,
    :age,
    :city,
    :hobbies
  ]

  # Create an empty list of students
  students = []
  
  loop do
    # Check if the user wants to add a student.
    puts "Add a student to the list? (y/n)"
    continue = gets.chomp
    while !["y", "n"].include?(continue)
      puts "Please answer 'y' or 'n'. Add a student to the list? (y/n)"
      continue = gets.chomp
    end
    break if continue == "n"

    # Create an empty student hash
    student = Hash.new("N/A")
    # Ask the user to fill information for each data_field
    for element in students_data_fields
      puts "Please enter the #{element.to_s} of the student"
      input = gets.chomp
      student[element] = input if input != ""
    end

    # Add student hash to the students list
    students << student
  end
  # return the array of students
  students
end

students = input_students

# let's put all students into an array
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

# nothing happens until we call the methods
print_header
print(students)
print_footer(students)