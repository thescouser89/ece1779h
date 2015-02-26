package ca.utoronto.ece1779.database;

import java.sql.*;
import java.util.LinkedList;
import java.util.List;

public class Image {

    private int id;
    private int userId;
    private String originalImage;
    private String firstTransformation;
    private String secondTransformation;
    private String thirdTransformation;

    public Image(int id, int userId,
                 String originalImage,
                 String firstTransformation,
                 String secondTransformation,
                 String thirdTransformation) {
        this.id = id;
        this.userId = userId;
        this.originalImage = originalImage;
        this.firstTransformation = firstTransformation;
        this.secondTransformation = secondTransformation;
        this.thirdTransformation = thirdTransformation;
    }

    public Image(int userId,
                 String originalImage,
                 String firstTransformation,
                 String secondTransformation,
                 String thirdTransformation) {
        this.id = 0;
        this.userId = userId;
        this.originalImage = originalImage;
        this.firstTransformation = firstTransformation;
        this.secondTransformation = secondTransformation;
        this.thirdTransformation = thirdTransformation;
    }

    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getOriginalImage() {
        return originalImage;
    }

    public void setOriginalImage(String originalImage) {
        this.originalImage = originalImage;
    }

    public String getFirstTransformation() {
        return firstTransformation;
    }

    public void setFirstTransformation(String firstTransformation) {
        this.firstTransformation = firstTransformation;
    }

    public String getSecondTransformation() {
        return secondTransformation;
    }

    public void setSecondTransformation(String secondTransformation) {
        this.secondTransformation = secondTransformation;
    }

    public String getThirdTransformation() {
        return thirdTransformation;
    }

    public void setThirdTransformation(String thirdTransformation) {
        this.thirdTransformation = thirdTransformation;
    }

    public static List<Image> getAllImages() {
        List<Image> images = new LinkedList<Image>();
        Connection con = DatabaseConnection.getInstance().getConnection();
        String query = "SELECT * from images";

        try {
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                int id = rs.getInt("id");
                int userId = rs.getInt("userId");
                String originalImage = rs.getString("key1");
                String firstTransformation = rs.getString("key2");
                String secondTransformation = rs.getString("key3");
                String thirdTransformation = rs.getString("key4");
                images.add(new Image(id, userId,
                        originalImage,
                        firstTransformation,
                        secondTransformation,
                        thirdTransformation));
            }

            return images;

        } catch (SQLException e) {
            e.printStackTrace();
            return images;
        } finally {
            closeConnection(con);
        }
    }

    public static int findIdOfImage(Image newImage) {
        int userId = newImage.getUserId();
        String originalImage = newImage.getOriginalImage();
        String firstTransformation = newImage.getFirstTransformation();
        String secondTransformation = newImage.getSecondTransformation();
        String thirdTransformation = newImage.getThirdTransformation();

        List<Image> images = Image.findImagesWithUserId(userId);
        for (Image image: images) {
            if (image.getOriginalImage().equals(originalImage) &&
                    image.getFirstTransformation().equals(firstTransformation) &&
                    image.getSecondTransformation().equals(secondTransformation) &&
                    image.getThirdTransformation().equals(thirdTransformation)) {
                return image.getId();
            }
        }
        return 0;
    }
    public static List<Image> findImagesWithUserId(int userId) {
        Connection con = DatabaseConnection.getInstance().getConnection();
        String query = "SELECT * from images where userId = " + userId;
        List<Image> images = new LinkedList<Image>();

        try {
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                int id = rs.getInt("id");
                String originalImage = rs.getString("key1");
                String firstTransformation = rs.getString("key2");
                String secondTransformation = rs.getString("key3");
                String thirdTransformation = rs.getString("key4");
                images.add(new Image(id, userId,
                        originalImage,
                        firstTransformation,
                        secondTransformation,
                        thirdTransformation));
            }
            return images;

        } catch (SQLException e) {
            e.printStackTrace();
            return images;
        } finally {
            closeConnection(con);
        }
    }

    /**
     * Save a new Image to the database
     * <p/>
     * Note that you don't have to specify the id in the Image object. It will
     * be created automatically by the image.
     *
     * @param newImage: Image object
     * @return whether the save was successful or not.
     */
    public static int addImage(Image newImage) {
        Connection con = DatabaseConnection.getInstance().getConnection();

        String insert = "INSERT INTO images(id, userId, key1, key2, key3, key4) VALUES(?, ?, ?, ?, ?, ?);";

        try {
            // Using prepared statement to avoid SQL injections
            PreparedStatement ps = con.prepareStatement(insert);

            // set id null so that it is auto-generated by MySQL
            ps.setNull(1, Types.INTEGER);
            ps.setInt(2, newImage.getUserId());
            ps.setString(3, newImage.getOriginalImage());
            ps.setString(4, newImage.getFirstTransformation());
            ps.setString(5, newImage.getSecondTransformation());
            ps.setString(6, newImage.getThirdTransformation());

            ps.execute();


            return Image.findIdOfImage(newImage);

        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        } finally {
            closeConnection(con);
        }
    }

    public static boolean modifyImage(Image image) {
        Connection con = DatabaseConnection.getInstance().getConnection();

        String update = "UPDATE images SET userId=?, key1=?, key2=?, key3=?, key4=? WHERE id=?";

        try {
            // Using prepared statement to avoid SQL injections
            PreparedStatement ps = con.prepareStatement(update);

            ps.setInt(1, image.getUserId());
            ps.setString(2, image.getOriginalImage());
            ps.setString(3, image.getFirstTransformation());
            ps.setString(4, image.getSecondTransformation());
            ps.setString(5, image.getThirdTransformation());
            ps.setInt(6, image.getId());

            ps.execute();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeConnection(con);
        }
    }

    public static boolean deleteImage(Image toDelete) {
        Connection con = DatabaseConnection.getInstance().getConnection();

        String delete = "Delete FROM images WHERE id=" + toDelete.getId();

        try {
            Statement stmt = con.createStatement();
            stmt.execute(delete);
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeConnection(con);
        }
    }

    public static boolean deleteAll() {
        String delete = "Delete FROM images";
        Connection con = DatabaseConnection.getInstance().getConnection();

        try {
            Statement stmt = con.createStatement();
            stmt.execute(delete);
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeConnection(con);
        }
    }

    private static void closeConnection(Connection con) {
        try {
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Could not close connection");
        }
    }

}
