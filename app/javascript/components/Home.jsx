import React from "react";
import { Link } from "react-router-dom";
import Pharmacy from './pharmacy';



class SPA extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      latitude: '38.929333',
      longitude: '-94.646873',
    }

    this.handleLatUpdate = this.handleLatUpdate.bind(this);
    this.handleLonUpdate = this.handleLonUpdate.bind(this);
    this.handleButton = this.handleButton.bind(this);
    this.fetchNearestPharmacy = this.fetchNearestPharmacy.bind(this);
  }

  handleLatUpdate(event) {
    this.setState({latitude: event.target.value})
  }

  handleLonUpdate(event) {
    this.setState({longitude: event.target.value})
  }

  handleButton(event) {
    this.fetchNearestPharmacy();
  }

  fetchNearestPharmacy() {
    const { latitude, longitude } = this.state;
    fetch(`http://localhost:3000/pharmacy?latitude=${latitude}&longitude=${longitude}`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      },
    })
    .then(response => response.json())
    .then(data => {
      this.setState({ pharmacy: data.pharmacy})
    })
    .catch((err) => {
      console.log(err);
      this.setState({pharmacy: null});
    });
  }

  render() {
    const { pharmacy } = this.state;
    return (
      <>
        <h1>Locate Nearest Phramacy</h1>
        <form>
          <label>
            latitude:
            <input type="text" name="latitude" id="input_latitude" defaultValue={this.state.latitude} onChange={this.handleLatUpdate} />
          </label>
          <label>
            longitude:
            <input type="text" name="longitude" id="input_longitude" defaultValue={this.state.longitude} onChange={this.handleLonUpdate} />
          </label>
        </form>
        <button type="submit" onClick={this.handleButton}>Find Nearest Pharmacy</button>
        {this.state.pharmacy && <Pharmacy name={pharmacy.name} address={pharmacy.address} distance={pharmacy.distance} />}
      </>
    );
  }

} 



export default SPA;
