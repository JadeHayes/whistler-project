class RatingChart extends React.Component {
  constructor(props){
    super(props);
    this.state = { ratings: []};
  }

componentWillMount() {
         fetch('/get-ratings.json?skirun_id=' + this.props.skirunId)
          .then((response)=> response.json())
          .then((data) => { this.setState({ratings: data.ratings})}
          );
    };


  render(){
    let rows =[];
    for (let i = 0; i < this.state.ratings.length; i++){
      let rating = this.state.ratings[i];
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

ReactDOM.render(
    <RatingChart skirunId={ skirunId }/>,
    document.getElementById("root")
);
