package ca.uqam.info;

import static org.junit.Assert.*;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.util.LinkedHashSet;
import java.util.Set;
import java.io.OutputStream;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class DatabaseLauncherTest {
  private final ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
  private final PrintStream originalOut = System.out;

  @Before
  public void setUp() {
    // Redirect System.out to capture printed output
    System.setOut(new PrintStream(outputStream));
  }

  @After
  public void tearDown() {
    // Restore the original System.out
    System.setOut(originalOut);
  }

  @Test
  public void testPrintStudents() throws IOException {
    Set<String> students = new LinkedHashSet<>();
    students.add("Alice");
    students.add("Bob");

    DatabaseLauncher.printStudents(students);

    String output = outputStream.toString();
    assertTrue(output.contains("Students in DB:"));
    assertTrue(output.contains(" * Alice"));
    assertTrue(output.contains(" * Bob"));
  }

  @Test
  public void testMain() throws IOException {
    // Run main method
    DatabaseLauncher.main(new String[]{});

    String output = outputStream.toString();

    assertTrue(output.contains("Students in DB:"));
    assertTrue(output.contains(" * Max"));
    assertTrue(output.contains(" * Ryan"));
    assertTrue(output.contains(" * Quentin"));
    assertTrue(output.contains(" * Romain"));
  }

}