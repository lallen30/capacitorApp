import { Component } from '@angular/core';
import { MapboxPlugin } from 'mapbox-plugin';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage {

  constructor() { }

  async showHelloWorld() {
    await MapboxPlugin.showHelloWorld();
  }

}
