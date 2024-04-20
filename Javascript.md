# Debuggear en fire fox
Source used: https://stackoverflow.com/questions/48059983/react-debug-using-vscode-and-firefox-instead-of-chrome
We need to set up
1. Set some Firefox settings and run firefox with special command
We must go to `about:settings`, in here we enter
- devtools.debugger.remote-enabled = true
- devtools.chrome.enabled = true
- devtools.debugger.workers = true (Required to debug Web Workers)
- devtools.debugger.workers
- devtools.debugger.prompt-connection = false
- devtools.debugger.force-local = false (Required ONLY if we want to attach vs code to firefox running on a different machine)

After this, we must start firefox using this command
```
firefox -start-debugger-server -no-remote
```

2.5 You may need to add to your PATH firefox if on Windows to start firefox from terminal
2. Create a launch json
You must make this launch.json
```javascript
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Debug app",
            "type": "firefox",
            "request": "attach"
        }
    ]
}
```

3. Install Firefox debugger in vscode

And done, now you should have fire fox running, then we run the react app with `npm start`, copy the address and put it in firefox, and finally run the debugger in vs code, with all our break points set

# React Component
These are **functions or classes**, that contain JSX 
> NOTE: EVERY JSX **MUST** start with an opening and closing html syntax

## Limitation
EACH component must equal to a file, where all the other parts of it reside

## Function definition
These are pretty simple, you just need to make a normal function BUT in the return part, it must contain the JSX syntax with your elements like this:
```javascript
function YourComponent(props) {
  // Component logic here
  return <div>This is YourComponent</div>;
}
```
- Simple and concise syntax.
- Used for presentational components or components that don't need state or lifecycle methods.
- Most components can be written as functional components, especially with the introduction of hooks.
## Class definition
Regarding the classes, you must make a class that inherits from another class, AND it must contain a `render()` function defined, which contains the JSX syntax and your elements like this
```javascript
class YourComponent extends React.Component {
  render() {
    // Component logic here
    return <div>This is YourComponent</div>;
  }
}
```
- More verbose syntax compared to function components.
- Used for components that need to manage state, lifecycle methods, or have complex logic.
- Older approach, but still widely used, especially in existing codebases.
## Usage
To use this you must:
1. **First import it**, in order to be accessible
2. **Use it** through this syntax
```javascript
<MyComponent />
```
3. (Optional) **Pass properties to component**, this lets us pass *arguments* to components just like functions, this is done by putting the properties we want to modify like html parts, like: 
```javascript
<Route path="/banking" element={<BankingFeed />} />
```
# Hooks