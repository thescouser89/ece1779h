package ca.utoronto.ece1779.database;

import org.junit.Ignore;
import org.junit.Test;
import ca.utoronto.ece1779.database.User;

import java.util.UUID;

@Ignore
public class UserTest {

    private static String userLogin = generateRandomString();

    @Test
    public void createAndDeleteUser() {
        User user = new User(userLogin, "usertest");
        User.addUser(user);

        User delete = User.findUser(userLogin);
        User.deleteUser(delete);
    }

    @Test
    public void listUsers() {
        User.getAllUsers();
    }

    @Test
    public void modifyUser() {
        String randomLogin = generateRandomString();
        User user = new User(randomLogin, "usertest");
        User.addUser(user);
        User retrieve = User.findUser(randomLogin);
        retrieve.setPassword("usertestmod");
        User.modifyUser(retrieve);

        User.deleteUser(retrieve);
    }

    private static String generateRandomString() {
        String uuid = UUID.randomUUID().toString();
        return uuid.substring(0, 15);
    }
}
