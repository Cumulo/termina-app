
var
  deku $ require :deku

var
  Directory $ deku.element.bind null $ require :./directory
  Draft $ deku.element.bind null $ require :./draft
  Command $ deku.element.bind null $ require :./command
  Monitor $ deku.element.bind null $ require :./monitor
  History $ deku.element.bind null $ require :./history
  div $ deku.element.bind null :div

= module.exports $ {}
  :propTypes $ {}
    :store $ {} (:type :object)

  :render $ \ (component setState)
    var store component.props.store
    var activeProcs $ ... store
      get :procs
      filter $ \ (proc) (proc.get :active)
    var inactiveProcs $ ... store
      get :procs
      filter $ \ (proc) (not (proc.get :active))

    div ({} (:class :app-layout))
      div ({} (:class :app-header))
        Directory $ {} (:store store)
        Command $ {} (:store store)
        Draft $ {} (:store store)
      div ({} (:class :app-body))
        div ({} (:class :active-group))
          ... activeProcs (toArray)
            map $ \ (proc)
              Monitor $ {} (:proc proc) (:key (proc.get :pid))
        div ({} (:class :inactive-group))
          ... inactiveProcs (toArray)
            map $ \ (proc)
              History $ {} (:proc proc) (:key (proc.get :pid))