import { LightningElement, wire, api, track } from 'lwc';
import getWeatherForCity from '@salesforce/apex/WeatherController.getWeatherForCity';

export default class WeatherInfoLwc extends LightningElement {
    @track weatherData;
    @track error;

    @api cityName = 'London'; // Exemplu de oraș, poate fi modificat sau setat dinamic

    @wire(getWeatherForCity, { cityName: '$cityName' })
    wiredWeather({ error, data }) {
        if (data) {
            this.weatherData = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.weatherData = undefined;
        }
    }

    // Getter pentru descrierea vremii
    get weatherDescription() {
        // Verifică dacă weatherData și weatherData.weather[0] există înainte de a accesa .description
        return this.weatherData && this.weatherData.weather && this.weatherData.weather[0] && this.weatherData.weather[0].description
            ? this.weatherData.weather[0].description
            : '';
    }
}
