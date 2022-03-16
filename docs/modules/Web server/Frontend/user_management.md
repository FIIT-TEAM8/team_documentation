# User management

User management is realised through the react context.

## Initial state

We define the initial state of the user context in `Utils/UserContext.js`.

The initial state is set as:
```
{
    user: {},
    accessToken: undefined
}
```
This state can be accessed from any component through the `UserProvider` component.

## User provider

The `UserProvider` component is defined in `Components/UserProvider.jsx`. To allow components handle user login and logout and access information defined in user context, the provider component is rendered in the core `App` component.

User provider contains function for log in and log out process. Those functions handle the user state - when logged in, the user data is filled by server response; when logged out, the data is cleared. To extend the user management scope, simply add the required functionality to the provider component and pass the new arguments to the user context when returning:
```
import { UserContext } from "../Utils/UserContext";


export default function UserProvider({children}) {
    const [accessToken, setAccessToken] = ...;
    const [user, setUser] = ...;

    const login = (loginData) => {
        ...
    };

    const logout = () => {
        ...
    };

    const newFeature = () => {
        console.log("This is an amazing new feature!")
    };

    return (
        <UserContext.Provider value={{ user, accessToken, login, logout, newFeature }}>
            {children}
        </UserContext.Provider>
    );
}
```
Child components can use the features defined in User provider as follows:
```
import { useUser } from "../Utils/UserContext";

export default function SomeComponent({}) {
    const { user, login, logout } = useUser();

    const onLogin = (loginData) => {
        const response = login(loginData);
        if (response.ok){
            console.log("Welcome " + user.name + "!");
        }
        else{
            console.log("Wrong credentials!");
        }
    };

    const onLogout = () => {
        logout();
        console.log("Successfully logged out!");
    };

    return (
        <div>
        ...
        <div/>
    );
}
```

