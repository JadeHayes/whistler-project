class Lift extends React.Component {
  constructor(props){
    super(props);
    this.state = { foodExist: this.props.foodExist};
  }

  componentWillMount() {
         fetch('/get-food.json?lift_id=' + this.props.liftId)
          .then((response)=> response.json())
          .then((data) => { this.setState({foodExist: data});}
          );
    }


  render(){
    return (
      <div>
        <img src="https://s-media-cache-ak0.pinimg.com/originals/5f/23/d4/5f23d47df4ee88438ef9b5e7f2701481.jpg" className='col-xs-12' />
      </div>);
  }
}

ReactDOM.render(
  // if (this.props.userLoggedI)
    <Lift/>,
    document.getElementById("root")
);
