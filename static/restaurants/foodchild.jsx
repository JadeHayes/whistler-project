class FoodChild extends React.Component {
  render() {
    let rows = [];
    for (let i = 0; i < this.props.restaurants.length; ++i) {
        let restaurant = this.props.restaurants[i];
        rows.push(<tr key={restaurant.name}>
          <td><button className="btn btn-link" onClick={this.props.showModalHandler}>{restaurant.name}</button></td>
          <td>{restaurant.location}</td>
          <td>{restaurant.description}</td></tr>);
    }
      return (
        <div display="inline-block">
        <table width="200" className="table table-striped" >
        <thead>
          <tr><th>Restaurant Name </th><th>Description</th></tr></thead>
        <tbody>{rows}</tbody>
      </table> 
      </div>
      );
    }
  }