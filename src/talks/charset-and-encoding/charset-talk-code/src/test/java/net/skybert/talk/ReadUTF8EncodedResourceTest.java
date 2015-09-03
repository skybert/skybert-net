package net.skybert.talk;

import java.io.IOException;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

/**
 * ReadUTF8EncodedResourceTest
 *
 * @author Torstein Krause Johansen
 * @version $Revision$ $Date$
 */
public class ReadUTF8EncodedResourceTest {
  ReadUTF8EncodedResources app;

  @Before
  public void setup() {
    app = new ReadUTF8EncodedResources();
  }

  @Test
  public void canReadISO88591EncodedResourceBundle() {
    Assert.assertEquals(
      "Read escaped Unicode string",
      "This is a \ud83d\udc7b",
      app.getPropertyFromLatin1File("ghost_title"));
  }

  @Test
  public void canReadUTF8EncodedResourceBundle() throws IOException {
    Assert.assertEquals(
      "Read escaped Unicode string",
      "ghost_title=This is a ????",
      app.getPropertyFromUTF8File("ghost_title"));
  }
}
