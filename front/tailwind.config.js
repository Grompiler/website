module.exports = {
  content: ["./src/**/*.elm", "./index.html"],
  theme: {
    screens: {
      sm: '400px',
      md: '768px',
      lg: '1024px',
      xl: '1280px',
    },
    colors: {
      'blue': '#25B2BC',
      'purple': '#B877DB',
      'pink': '#E95379',
      'orange': '#F09383',
      'red': '#E95678',
      'green': '#27D796',
      'yellow': '#FAC29A',
      'gray-dark': '#232530',
      'gray': '#2E303E',
      'gray-light': '#6C6F93',
      'black-dark': '#16161C',
      'black': '#1A1C23',
      'black-light': '#1C1E26',
      'white-dark': '#F9CBBE',
      'white': '#FADAD1',
      'white-light': '#FDF0ED',
    },
    fontFamily: {
      sans: ['JetBrains Mono', 'sans-serif'],
      serif: ['JetBrains Mono', 'serif'],
    },
    //   extend: {
    //     spacing: {
    //       '128': '32rem',
    //       '144': '36rem',
    //     },
    //     borderRadius: {
    //       '4xl': '2rem',
    //     }
    //   }
  },
  plugins: [],
}
