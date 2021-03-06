package net.skybert.talk;

import org.junit.Assert;
import org.junit.Test;

/**
 * FindCharacterAtPoint
 *
 * @author Torstein Krause Johansen
 * @version $Revision$ $Date$
 */
public class FindCodePointTest {
  @Test
  public void canFindCodePointForTilde() {
    Integer expected = 126;
    Integer actual = FindCodePoint.findCodePoint("~");
    Assert.assertEquals("Code point for tilde", expected, actual);
  }

  @Test
  public void canFindCodePointForGhost() {
    Integer expected = 128123;
    Integer actual = FindCodePoint.findCodePoint("👻");
    Assert.assertEquals("Code point for ghost", expected, actual);
  }

}
