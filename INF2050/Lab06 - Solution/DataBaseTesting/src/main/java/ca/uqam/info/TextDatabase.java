package ca.uqam.info;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.Set;
import org.apache.commons.io.FileUtils;

/**
 * Simple textual database. Allows to store a Set of students on disk. Students have only a first name.
 *
 * @author Maximilian Schiedermeier
 */
public class TextDatabase {

  // Path to database file.
  // Note: If you're on windows your path will be something like: "C:\Users\Schieder\Desktop\studentdb.txt"
  private File db;

  public TextDatabase() {
    this(new File("src/main/resources/studentdb.text"));
  }
  public TextDatabase(File db) {
    this.db = db;
    if(!db.exists()) throw new RuntimeException("Student DB does not exists. Makes sure the file" +
        " \"studentdb.txt\" exists and matches the path specified in line 20.");
  }

  public void addStudent(String student) throws IOException {

    // read DB
    Set<String> students = readDataBase();

    // add student
    students.add(student);

    // write DB
    writeDataBase(students);
  }

  public void removeStudent(String student) throws IOException {

    // read DB
    Set<String> students = readDataBase();

    // remove student (has no effect if student does not exist)
    students.remove(student);

    // write DB
    writeDataBase(students);
  }

  public Set<String> readDataBase() throws IOException {
    String fileContent = FileUtils.readFileToString(db, Charset.forName("UTF-8"));
    String[] studentsArray = fileContent.split("\\s+");
    Set<String> students = new LinkedHashSet<>();
    Collections.addAll(students, studentsArray);
    return students;
  }

  public void writeDataBase(Set<String> students) throws IOException {
    FileUtils.writeStringToFile(db, studentSetToString(students), Charset.forName("UTF-8"));
  }

  /**
   * Helper method to convert Set of strings into string representation, items separated by spaces.
   * @param students as the set of student names to convert to string
   * @return multi line string with all student names.
   */
  private String studentSetToString(Set<String> students) {
    String studentsString = "";
    for (String student : students) {
      studentsString += student + " ";
    }
    return studentsString.trim();
  }
}
