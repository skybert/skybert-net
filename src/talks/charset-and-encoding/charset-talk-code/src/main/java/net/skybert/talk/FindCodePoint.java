package net.skybert.talk;

/**
 * FindCodePoint
 *
 * @author Torstein Krause Johansen
 * @version $Revision$ $Date$
 */
public class FindCodePoint {
  public static void main(String[] args) {
    if (args.length != 1) {
      System.out.println("Usage: "
                         + FindCodePoint.class.getName()
                         + " <character>");
      System.exit(1);
    }

    String s = args[0];

    int codePoint = Character.codePointAt(s, 0);
    System.out.println("The codepoint of " + s + " is " + codePoint);
    System.out.println("If BMP, the codepoint of " + s + " is " + (int) s.charAt(0));
  }

  public static Integer findCodePoint(final String s) {
    return Character.codePointAt(s, 0);
  }

  public static Integer findCodePointfInBMP(final String s) {
    return (int) s.charAt(0);
  }
}
