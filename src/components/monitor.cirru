
var
  React $ require :react/addons
  Immutable $ require :immutable
  classnames $ require :classnames
  view $ require :../view

var
  Lightbox $ React.createFactory $ require :react-origami-lightbox
  Display $ React.createFactory $ require :./display
  div $ React.createFactory :div
  span $ React.createFactory :span
  pre $ React.createFactory :pre
  svg $ React.createFactory :svg
  polygon $ React.createFactory :polygon

= module.exports $ React.createClass $ {}
  :mixins $ [] React.addons.PureRenderMixin
  :propTypes $ {}
    :proc $ React.PropTypes.instanceOf Immutable.Map

  :getInitialState $ \ ()
    {} (:showPop false)

  :onClose $ \ (event)
    view.action $ {}
      :type :stop
      :data $ this.props.proc.get :pid

  :onFlush $ \ (event)
    view.action $ {}
      :type :flush
      :data $ this.props.proc.get :pid

  :onRedo $ \ (event)
    view.action $ {}
      :type :start
      :data $ this.props.proc.get :command

  :onPopClose $ \ ()
    this.setState $ {} (:showPop false)

  :onPopShow $ \ ()
    this.setState $ {} (:showPop true)

  :renderPop $ \ ()
    Lightbox
      {} (:show this.state.showPop) (:onClose this.onPopClose)
      Display $ {} (:proc this.props.proc)

  :renderStdout $ \ ()
    var stdout $ ... this.props.proc (get :stdout) (join :)
    var lines $ stdout.split ":\n"
    if (> lines.length 10)
      do
        var lastLines $ lines.slice -6
        return $ div ({} (:className :rich-stdout) (:onClick this.onPopShow))
          div ({} (:className :more))
          pre ({} (:className :stdout)) (lastLines.join ":\n")
      do
        return $ pre ({} (:className :stdout)) (lines.join ":\n")
    return undefined

  :render $ \ ()
    var proc this.props.proc
    var className $ classnames :app-monitor $ {}
      :is-alive $ proc.get :alive

    div ({} $ :className className)
      div ({} (:className :header))
        div ({} (:className ":info line"))
          span ({} (:className :command)) (proc.get :command)
        cond (proc.get :alive)
          div ({} (:className :control))
            svg ({} (:className :close) (:width 32) (:height 32))
              polygon $ {}
                :className :trigger
                :points ":0,0 32,0 32,32"
                :onClick this.onClose
          , undefined
      this.renderStdout
      div ({} (:className ":line monitor-control"))
        cond (proc.get :alive)
          div
            {} (:className ":button is-attract") (:onClick this.onFlush)
            , :flush
          div
            {} (:className ":button is-attract") (:onClick this.onRedo)
            , :Redo
      this.renderPop
