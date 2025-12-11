package ca.uqam.info;

import java.io.File;
import java.io.IOException;
import java.util.LinkedHashSet;
import java.util.Set;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

public class DataBaseTest {
  private TextDatabase studentDatabase;
  @Before
  public void connectToDatabase() throws Exception {
    studentDatabase = new TextDatabase();
  }
  @After
  public void tearDown() throws Exception {
    Set<String> students = studentDatabase.readDataBase();
    for (String student : students) { studentDatabase.removeStudent(student);}
    studentDatabase.addStudent("Max");
    studentDatabase.addStudent("Ryan");
    studentDatabase.addStudent("Quentin");
    studentDatabase.addStudent("Romain");
  }
  @Test
  public void testDatabaseRead() throws IOException {
    Set<String> students = studentDatabase.readDataBase();
    Set<String> expectedResult = new LinkedHashSet<>();
    expectedResult.add("Max");
    expectedResult.add("Ryan");
    expectedResult.add("Quentin");
    expectedResult.add("Romain");
    Assert.assertEquals("Database does not contain default students", expectedResult, students);
  }

  @Test
  public void testAddStudent() throws IOException {
    studentDatabase.addStudent("Hafedh");
    Set<String> students = studentDatabase.readDataBase();
    Set<String> expectedResult = new LinkedHashSet<>();
    expectedResult.add("Max");
    expectedResult.add("Ryan");
    expectedResult.add("Quentin");
    expectedResult.add("Romain");
    expectedResult.add("Hafedh");
    Assert.assertEquals("Database does not contain new student", expectedResult, students);
  }

  @Test
  public void testRemoveStudent() throws IOException {
    studentDatabase.removeStudent("Max");
    Set<String> students = studentDatabase.readDataBase();
    Set<String> expectedResult = new LinkedHashSet<>();
    expectedResult.add("Ryan");
    expectedResult.add("Quentin");
    expectedResult.add("Romain");
    Assert.assertEquals("Database does not contain expected students", expectedResult, students);
  }
  @Test(expected = Exception.class)
  public void testDatabaseDoesNotExist() {
    // Create a new TextDatabase instance with a non-existent file
    File tempDbFile = new File("src/main/resources/nonexistentdb.txt");

    // Ensure the file does not exist
    if (tempDbFile.exists()) {
      tempDbFile.delete();
    }

    // This should throw a RuntimeException since the file does not exist
    new TextDatabase(tempDbFile);
  }
}
