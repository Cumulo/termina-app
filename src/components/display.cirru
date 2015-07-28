
var
  React $ require :react
  Immutable $ require :immutable

var
  div $ React.createFactory :div
  pre $ React.createFactory :pre

= module.exports $ React.createClass $ {}
  :displayName :app-display

  :propTypes $ {}
    :proc $ React.PropTypes.instanceOf Immutable.Map

  :render $ \ ()
    div ({} (:className :app-display))
      div ({} (:className :command))
        this.props.proc.get :command
      pre ({} (:className :stdout))
        this.props.proc.get :stdout