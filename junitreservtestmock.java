import org.junit.*;
import static org.junit.Assert.*;
import static org.mockito.Mockito.*;

public class ReservationServiceTest {

    private ReservationService reservationService;
    private Database databaseMock;

    @Before
    public void setUp() {
        databaseMock = mock(Database.class); // Mock your database access class
        reservationService = new ReservationService(databaseMock);
    }

    @Test
    public void testMakeReservation() {
        // Set up your mock to expect a reservation creation
        when(databaseMock.createReservation(anyString(), anyInt(), any(), any())).thenReturn(true);

        // Call the method under test
        boolean result = reservationService.makeReservation("testUser", 1, "2023-11-17 9:00:00", "2023-11-17 9:30:00");

        // Assert the expected result
        assertTrue("Reservation should be successful", result);

        // Verify that the database method was called
        verify(databaseMock).createReservation("testUser", 1, "2023-11-17 9:00:00", "2023-11-17 9:30:00");
    }
}
