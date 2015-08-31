import java.nio.charset.Charset;
/**
 * UsingSystemOut
 *
 * @author Torstein Krause Johansen
 * @version $Revision$ $Date$
 */
public class UsingSystemOut {
    public static void main(String[] args) {
        Charset defaultCharset = Charset.defaultCharset();
        System.out.println("System.out.println" + " uses the system's default encoding=" + defaultCharset);
        System.out.println("Can be overridden with"
                           + " -Dfile.encoding="
                           + System.getProperty("file.encoding")
                           );

        System.out.print("\u00A3\u044F");
    }
}
