class Lift extends React.Component {
  constructor(props){
    super(props);
    this.state = { restaurants: []};
  }

  componentWillMount() {
         fetch('/get-lift-info.json?lift_id=' + this.props.liftId)
          .then((response)=> response.json())
          .then((data) => { this.setState({restaurants: data});}
          );
    }
    
    

  render(){
    return (
      <div>
        I am REACT
        <img src="https://s-media-cache-ak0.pinimg.com/originals/5f/23/d4/5f23d47df4ee88438ef9b5e7f2701481.jpg" className='col-xs-12' />
      </div>);
}


}

ReactDOM.render(
    <Lift liftId={ liftId }/>,
    document.getElementById('root')
    )

