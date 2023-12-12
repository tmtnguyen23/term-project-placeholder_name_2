import org.junit.*;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import java.util.concurrent.TimeUnit;
import static org.junit.Assert.*;

public class MakeReservationTest {
    private WebDriver driver;
    private String baseUrl;

    @Before
    public void setUp() throws Exception {
        System.setProperty("webdriver.chrome.driver", "lib\\win\\chromedriver.exe");
        driver = new ChromeDriver();
        baseUrl = "http://localhost:8080/term-project-placeholder_name_2";
        driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
    }

    @Test
    public void testMakeReservation() throws Exception {
    	// Log in before making a reservation
    	driver.get(baseUrl + "/login.html");
    	driver.findElement(By.name("user")).sendKeys("testUser");
    	driver.findElement(By.name("pwd")).sendKeys("password");
    	driver.findElement(By.name("submit")).click(); // Adjust if the login button has a different name or type

    	// Navigate to New Reservation page
    	// Replace with actual link to the new reservation page
    	driver.findElement(By.linkText("New Reservation")).click();

    	// Fill in the form for making a new reservation
    	// The names of the form elements will depend on your reservation form's input names
    	driver.findElement(By.name("machineId")).sendKeys("1");
    	driver.findElement(By.name("startTime")).sendKeys("2023-11-17 9:00:00");
    	driver.findElement(By.name("endTime")).sendKeys("2023-11-17 9:30:00");
    	driver.findElement(By.name("confirmReservation")).click(); // Use the actual name/id for the confirm button

    	// Verify the reservation was made successfully
    	// Replace with the actual success message or element that confirms a successful reservation
    	assertTrue(driver.findElement(By.id("reservationSuccessMessage")).isDisplayed());
    }

    @After
    public void tearDown() throws Exception {
        driver.quit();
    }
}
