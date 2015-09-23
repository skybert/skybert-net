title: Reading all image metadata from an image file
category: java
tags: java, iptc, exif

Reading all image metadata from a file, including all IPTC and EXIF
fields:

```java
import com.drew.imaging.*;
import com.drew.metadata.*;
import java.io.*;

public class ReadImageMetadata {
  public static void main(String[] args) throws IOException, ImageProcessingException {
    InputStream imageFile = new FileInputStream(args[0]);
    Metadata metadata = ImageMetadataReader.readMetadata(imageFile);
    System.out.println("read file=" + args[0]);

    for (Directory directory : metadata.getDirectories()) {
      System.out.println("  directory=" + directory);
      for (Tag tag : directory.getTags()) {
        System.out.println("    tag=" + tag);
      }
    }
  }
}
```

Usage:

```bash
$ javac ReadImageMetadata.java \
       -cp xmpcore-5.1.2.jar:metadata-extractor-2.8.1-sources.jar:metadata-extractor-2.8.1.jar
$ java ReadImageMetadata.java \
       -cp xmpcore-5.1.2.jar:metadata-extractor-2.8.1-sources.jar:metadata-extractor-2.8.1.jar \
       image.jpg
```
