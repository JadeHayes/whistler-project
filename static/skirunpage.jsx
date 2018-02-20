class SkirunPage extends React.Component {
  constructor(props){
    super(props);
    this.state = { ratings: [],
                    ratingsExist: this.props.ratingsExist};
    this.addRating = this.addRating.bind(this);
  }

  componentWillMount() {
         fetch('/get-ratings.json?skirun_id=' + this.props.skirunId)
          .then((response)=> response.json())
          .then((data) => { this.setState({ratings: data.ratings});}
          );
    }

  addRating(evt){
    evt.preventDefault();

    let formInputs = new FormData();

    let newScore = document.querySelector("input[name='rating']:checked").value;

    let comment = document.querySelector("#description").value;

    formInputs.append("rating", newScore);
    formInputs.append("skirun_id", this.props.skirunId);
    formInputs.append("description", comment);

    let fetchOptions = {"method": "POST",
                        "body": formInputs,
                         credentials: "same-origin"};

    fetch("/add-rating.json", fetchOptions)
        .then((response) => response.json())
        .then((data) => {
            let ratings = this.state.ratings;
            ratings.push(data.new_rating);
            this.setState({"ratings": ratings});
        }); 
      }

  render(){
    let form = [];
    if (this.props.userLoggedIn) {
        form.push(<RatingForm ratingsExist={this.state.ratingsExist} 
                    addRating={this.addRating}/>);
    }
    
    return (
      <div>
        <img src="https://cdn1.snowpak.com/resorts/banners/000/000/026/large/26_british-columbia_whistler-blackcomb.jpg?1517793603" className='col-xs-12' />
        { form }
        <RatingChart ratings= {this.state.ratings} />
      </div>);
  }
}

ReactDOM.render(
    <SkirunPage skirunId={ skirunId }
                 ratingsExist={ ratingsExist }
                 userLoggedIn={ userLoggedIn }/>,
    document.getElementById("root")
);
