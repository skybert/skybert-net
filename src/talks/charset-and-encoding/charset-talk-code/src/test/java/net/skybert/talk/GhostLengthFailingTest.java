package net.skybert.talk;

import org.junit.*;
import static org.junit.Assert.*;

/**
 * GhostLengthFailingTest
 *
 * @author Torstein Krause Johansen
 * @version $Revision$ $Date$
 */
public class GhostLengthFailingTest {

  @Test
  public void ghostIsOneCodeUnit() {
    String ghost = "👻";
    assertEquals("ghost is just one chracter", 1, ghost.length());
  }

}
