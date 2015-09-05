package net.skybert.talk;

import static org.junit.Assert.assertEquals;

import java.io.UnsupportedEncodingException;

import org.junit.Test;

/**
 * UnicodeStringTest
 *
 * @author Torstein Krause Johansen
 * @version $Revision$ $Date$
 */
public class UnicodeStringTest {
  final static String SMALL_A = "a";
  final static String GHOST = "👻";
  final static String HELLO_IN_MANDARIN = "你好";

  @Test
  public void numbersOfWeeA() throws Exception {
    String s = SMALL_A;

    assertEquals("UTF-8", 1, s.getBytes("UTF-8").length);

    // UTF-16 encoding inserts a two byte BOM
    assertEquals("UTF-16", 4, s.getBytes("UTF-16").length);

    assertEquals("UTF-32", 4, s.getBytes("UTF-32").length);

    assertEquals("a number of 16bit units", 1, s.length());
    assertEquals("a number of characters", 1, s.codePointCount(0, s.length()));

    printEncodingsOf(s);
  }

  @Test
  public void numbersOfTheGhost() throws Exception {
    String s = GHOST;
    assertEquals("UTF-8 encoded", 4, s.getBytes("UTF-8").length);

    // UTF-16 encoding inserts a two byte BOM
    assertEquals("UTF-16 encoded", 6, s.getBytes("UTF-16").length);

    assertEquals("UTF-32 encoded", 4, s.getBytes("UTF-32").length);
    assertEquals("ghost number of 16bit units", 2, s.length());
    assertEquals("ghost number of characters", 1, s.codePointCount(0, s.length()));

    printEncodingsOf(s);
  }

  private void printEncodingsOf(final String pValue)
    throws UnsupportedEncodingException {
    String[] encodings = {"UTF-8", "UTF-16", "UTF-32"};
    for (String encoding : encodings) {
      System.out.format(pValue + " encoded as %s ", encoding);
      for (byte b : pValue.getBytes(encoding)) {
        System.out.format("%02x ", b);
      }
      System.out.println();
    }
  }

  @Test
  public void numbersOfChineseHello() throws Exception {
    String s = HELLO_IN_MANDARIN;

    assertEquals("UTF-8 encoded", 6, s.getBytes("UTF-8").length);

    // UTF-16 encoding inserts a two byte BOM:
    // 2 byte BOM + 2 byte char 1 + 2 byte char 2
    assertEquals("UTF-16 encoded", 6, s.getBytes("UTF-16").length);

    assertEquals("UTF-32 encoded", 8, s.getBytes("UTF-32").length);

    assertEquals(
      "Chinese Hello has number 2 16bit units",
      2,
      s.length());
    assertEquals(
      "Chinese Helo is two characters",
      2,
      s.codePointCount(0, s.length()));

    printEncodingsOf(s);
    
  }


}
