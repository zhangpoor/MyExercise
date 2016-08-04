import React, { Component, PropTypes } from 'react';
import { StyleSheet, Navigator, TouchableHighlight, Text } from 'react-native';

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#F5FCFF',
        paddingTop: 64,
    },
    navbar: {
        backgroundColor: 'white',
        borderBottomColor: '#eee',
        borderBottomWidth: StyleSheet.hairlineWidth,
    },
    navbarItem: {
        padding: 10,
    },
    navbarTitle: {
        textAlign: 'center',
        marginTop: 8,
        fontSize: 18,
    },
});

class Nav extends Component {

    static propTypes = {
        routes: PropTypes.array,
    };

    constructor(props) {
        super(props);

        this.rightButton = this.rightButton.bind(this);
    }

    leftButton(route, navigator, index) {
        if (index === 0) return null;
        return (
            <TouchableHighlight underlayColor="transparent" onPress={() => navigator.pop()}>
                <Text style={styles.navbarItem}>Back</Text>
            </TouchableHighlight>
        );
    }

    rightButton(route, navigator, index) {
        const routes = this.props.routes;
        if (index >= routes.length - 1) return null;
        return (
            <TouchableHighlight underlayColor="transparent" onPress={() => navigator.push(routes[index + 1])}>
                <Text style={styles.navbarItem}>Next</Text>
            </TouchableHighlight>
        );
    }

    render() {
        const leftButton = this.leftButton;
        const rightButton = this.rightButton;
        const routes = this.props.routes;
        return (
            <Navigator
                style={styles.container}
                initialRoute={routes[0]}
                initialRouteStack={routes}
                renderScene={(route, navigator) => React.createElement(route.component, { ...route, navigator })}
                navigationBar={
                    <Navigator.NavigationBar
                        routeMapper={{
                            LeftButton: leftButton,
                            RightButton: rightButton,
                            Title: (route, navigator, index) => (<Text style={styles.navbarTitle}>{routes[index].title}</Text>),
                        }}
                        style={styles.navbar}
                    />
              }
            />
        );
    }
}

export default Nav;
