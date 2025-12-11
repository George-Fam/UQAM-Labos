package ca.uqam.info;

import java.io.IOException;
import java.util.Set;

/**
 * Launcher for student database. Does not do much, except printing all students in DB.
 */
public class DatabaseLauncher {
  private DatabaseLauncher(){}
  public static void main(String[] args) throws IOException {
    TextDatabase studentDatabase = new TextDatabase();
    printStudents(studentDatabase.readDataBase());
  }

  public static void printStudents(Set<String> students) throws IOException {
    System.out.println("Students in DB:");
    for (String student : students) {
      System.out.println(" * " + student);
    }
  }
}
