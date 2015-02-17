package ca.utoronto.ece1779.images;

import org.im4java.core.ConvertCmd;
import org.im4java.core.IMOperation;

public class ImageManipulation {

    public static void gothamFilter(final String sourceFile,
                                    final String destinationFile) {
        try {
            // create command
            ConvertCmd cmd = new ConvertCmd();

            // create the operation, add images and operators/options
            IMOperation op = new IMOperation();
            op.addImage(sourceFile);
            op.modulate(120d, 10d, 100d);
            op.fill("#332b6d");
            op.colorize(30);
            op.gamma(0.7);
            op.contrast();
            op.contrast();
            op.addImage(destinationFile);

            // execute the operation
            cmd.run(op);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void borderFilter(final String sourceFile,
                                    final String destinationFile) {
        try {
            // create command
            ConvertCmd cmd = new ConvertCmd();

            // create the operation, add images and operators/options
            IMOperation op = new IMOperation();
            op.addImage(sourceFile);
            op.bordercolor("black");
            op.border(50);
            op.addImage(destinationFile);

            // execute the operation
            cmd.run(op);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void hipsterFilter(final String sourceFile,
                                     final String destinationFile) {
        try {
            // create command
            ConvertCmd cmd = new ConvertCmd();

            // create the operation, add images and operators/options
            IMOperation op = new IMOperation();
            op.addImage(sourceFile);
            op.colorize(250);
            op.addImage(destinationFile);

            // execute the operation
            cmd.run(op);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
