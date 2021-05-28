public class ParkLocator {
    public static list<String> country (String park) {
        ParkService.ParksImplPort parkservice =
            new parkService.ParksImplPort();
        return parkservice.byCountry(park);
    }

}