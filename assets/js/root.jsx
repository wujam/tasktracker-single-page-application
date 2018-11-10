import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';
import $ from 'jquery';
import { Link, BrowserRouter as Router, Route } from 'react-router-dom';
import UserList from './user_list';
import { Provider } from 'react-redux';
import api from './api'

export default function root_init(node, store) {
  ReactDOM.render(
    <Provider store={store}>
      <Root tasks={window.tasks} />
    </Provider>, node);
}

class Root extends React.Component {
  constructor(props) {
    super(props);

    api.fetch_tasks()
	api.fetch_users()
  }

  render() {
    return <div>
      <Router>
        <div>
          <Header />
          <div className="row">
            <div className="col-8">
              <Route path="/" exact={true} render={() =>
                <TaskList />
              } />
              <Route path="/users" exact={true} render={() =>
                <UserList />
              } />
            </div>
          </div>
        </div>
      </Router>
    </div>;
  }
}

function Header(props) {
  let {root} = props;
  return <div className="row my-2">
    <div className="col-4">
      <h1><Link to={"/"} onClick={() => api.fetch_tasks()}>Task Tracker</Link></h1>
    </div>
    <div className="col-2">
      <p><Link to={"/users"} onClick={() => api.fetch_users()}>Users</Link></p>
    </div>
    <div className="col-6">
      <div className="form-inline my-2">
        <input type="email" placeholder="email" />
        <input type="password" placeholder="password" />
        <button className="btn btn-secondary">Login</button>
      </div>
    </div>
  </div>;
}

function TaskList(props) {
  let tasks = _.map(props.tasks, (p) => <Task key={p.id} task={p} />);
  return <div className="row">
    {tasks}
  </div>;
}

function Task(props) {
  let {task} = props;
  return <div className="card col-4">
    <div className="card-body">
      <h2 className="card-title">{task.name}</h2>
      <p className="card-text">{task.desc} <br/>
      Time Taken: {task.time_taken} <br/>
      Done: {"" + task.done} <br/>
      </p>
    </div>
  </div>;
}

function User(props) {
  let {user} = props;
  return <tr>
    <td>{user.email}</td>
    <td>{user.admin ? "yes" : "no"}</td>
    </tr>;
}
