package net.skybert.talk;
import java.util.Locale;
import java.io.InputStream;
import java.util.ResourceBundle;
import java.util.ResourceBundle.Control;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

/**
 * ReadUTF8EncodedResources
 *
 * @author Torstein Krause Johansen
 * @version $Revision$ $Date$
 */
public class ReadUTF8EncodedResources {
  private static final String FILE_UTF8 = "ghost-text.utf8";
  private static final String FILE_ISO_8859_1 = "/ghost-text.properties";

  public static void main(String[] args) {
  }

  public String getPropertyFromLatin1File(final String pKey) {
    ResourceBundle bundle = ResourceBundle.getBundle("ghost-text", Locale.ENGLISH);


    return bundle.getString(pKey);
  }

  public String getPropertyFromUTF8File(final String pKey) throws IOException {
    String content = new String(Files.readAllBytes(Paths.get(FILE_UTF8)));
    return content;
  }

}
