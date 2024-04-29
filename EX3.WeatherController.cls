public class WeatherController {

    public static final String API_KEY = '8012c9d5f59aef0e810dc5d0172683c0';
    public static final String ENDPOINT = 'https://api.openweathermap.org/data/2.5/weather';

    public static WeatherResponse getWeatherForCity(String cityName) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(ENDPOINT + '?q=' + EncodingUtil.urlEncode(cityName, 'UTF-8') + '&units=metric&appid=' + API_KEY);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            return (WeatherResponse) System.JSON.deserialize(response.getBody(), WeatherResponse.class);
        } else {
            System.debug('API call failed: ' + response.getStatusCode() + ' ' + response.getStatus());
            return null;
        }
    }
}