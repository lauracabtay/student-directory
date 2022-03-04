# Create an empty array
@students =[]

# Let's put all students into an array
def input_students
    puts "Please enter the names of the students"
    puts "To finish, just hit return twice"

    #Get the name
    name = gets.chomp

    # While the  name is not empty, repeat this code
    while !name.empty? do

        # Add the student hash to the array
        @students << {name: name, cohort: :november}
        puts "Now we have #{@students.count} students"

        # Get another name from the user
        name = STDIN.gets.chomp
    end

    # Return the array of students
    @students
end

def print_header
    puts "The students of Villains Academy"
    puts "------------"
end

def print(students)
    @students.each do | student |
        puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
end

def print_footer(students)
    puts "Overall, we have #{@students.count} great students"
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
    print(@students)
    print_footer(@students)
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
            exit # this will cause the program to terminate
        else
            puts "I don't know what you meant, try again"
    end
end

def interactive_menu
    loop do
        print_menu
        process(STDIN.gets.chomp)
    end
end

def save_students
    # open the file for writing
    file = File.open("students.csv", "w")
    # iterate over the array of students
    @students.each do | student |
        student_data = [student[:name], student[:cohort]]
        csv_line = student_data.join(",")
        file.puts csv_line
    end
    file.close
end

def load_students(filename = "students.csv")
    file = File.open(filename, "r")
    file.readlines.each do | line |
        name, cohort = line.chomp.split(",")
        @students << {:name => name, :cohort => cohort.to_sym}
    end
    file.close
end

def try_load_students
    filename = ARGV.first
    return if filename.nil?
    if File.exists?(filename)
        load_students(filename)
        puts "Loaded #{@students.count} from #{filename}"
    else
        puts "Sorry, #{filename} doesn't exist."
        exit
    end
end

try_load_students
interactive_menu
