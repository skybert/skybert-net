package net.skybert.talk;

import java.io.IOException;
import java.util.Locale;
import java.util.ResourceBundle;
import static java.util.ResourceBundle.getBundle;

/**
 * ReadUTF8EncodedResources
 *
 * @author Torstein Krause Johansen
 * @version $Revision$ $Date$
 */
public class ReadUTF8EncodedResources {

  public static void main(String[] args) {
  }

  public String getPropertyFromLatin1File(final String pKey) {
    ResourceBundle bundle = getBundle("ghost-text", Locale.ENGLISH);
    return bundle.getString(pKey);
  }

  public String getPropertyFromUTF8File(final String pKey) throws IOException {
    ResourceBundle bundle = getBundle("ghost-text-utf8", Locale.ENGLISH);
    String value = bundle.getString(pKey);
    return new String(value.getBytes("ISO-8859-1"), "UTF-8");
  }

}
