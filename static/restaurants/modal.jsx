class MyModal extends React.Component {
  render() {
    // Render nothing if the "show" prop is false
    if(!this.props.showModal) {
      return null;
    }
    console.log(("myModal"))

    // The gray background
    const backdropStyle = {
      position: 'fixed',
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      backgroundColor: 'rgba(0,0,0,0.3)',
      padding: 50
    };

    // The modal "window"
    const modalStyle = {
      backgroundColor: '#fff',
      borderRadius: 5,
      maxWidth: 500,
      minHeight: 300,
      margin: '0 auto',
      padding: 30
    };

    return (
      <div className="backdrop">
        <div className="modal">
          <div className="footer">
            <button onClick={this.props.onClose}>
              Close
            </button>
          </div>
        </div>
      </div>
    );
  }
}
MyModal.propTypes = {
  onClose: PropTypes.func,
  showModal: PropTypes.bool,
  children: PropTypes.node
};
