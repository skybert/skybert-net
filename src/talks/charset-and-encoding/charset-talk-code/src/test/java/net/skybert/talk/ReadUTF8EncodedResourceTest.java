package net.skybert.talk;

import static org.junit.Assert.assertEquals;

import java.io.IOException;

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
    assertEquals(
      "Read escaped Unicode string",
      "This is a \ud83d\udc7b",
      app.getPropertyFromLatin1File("ghost_title"));
  }

  @Test
  public void canReadUTF8EncodedResourceBundle() throws IOException {
    assertEquals(
      "Read escaped Unicode string",
      "This is a 👻",
      app.getPropertyFromUTF8File("ghost_title"));
  }
}
