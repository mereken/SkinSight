/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        primary: {
          50:  '#eef4fb',
          100: '#d6e4f0',
          200: '#add0e1',
          300: '#7bb4cf',
          400: '#4d96bc',
          500: '#2e86c1',
          600: '#1e6da0',
          700: '#175580',
          800: '#113d5f',
          900: '#1e3a5f',
        },
        skin: {
          oily:        '#fde68a',
          dry:         '#bfdbfe',
          sensitive:   '#fecaca',
          combination: '#d9f99d',
          normal:      '#d1fae5',
        },
        flag: {
          beneficial: '#16a34a',
          neutral:    '#6b7280',
          caution:    '#d97706',
          avoid:      '#dc2626',
        }
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
