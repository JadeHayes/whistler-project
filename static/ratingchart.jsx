class RatingChart extends React.Component {

  render(){
    let rows =[];
    for (let i = 0; i < this.props.ratings.length; i++){
      let rating = this.props.ratings[i];
      rows.push(<tr key={rating.rating_id}><td>{rating.rating }</td><td>{ rating.comment }</td></tr>);
    }
  
    return (
      <div>
      <table className='table table-striped container'>
        <thead>
          <tr><th>Rating</th><th>Comment</th></tr></thead>
        <tbody>{rows}</tbody>
      </table> 
      </div>);
  }
}
