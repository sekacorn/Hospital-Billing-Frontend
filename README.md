# Hospital Billing Frontend

A modern, responsive Angular application for hospital billing management with a sleek Bootstrap 5 UI. This frontend connects to the Hospital Billing Backend API to provide comprehensive diagnosis, physician, and treatment management capabilities.

## Features

- Modern Angular 17 standalone components architecture
- Responsive Bootstrap 5 UI design
- Real-time data management for diagnoses, physicians, and treatments
- RESTful API integration with backend
- Comprehensive form validation
- Error handling and user feedback
- Unit tests with Jasmine and Karma
- Docker support for containerized deployment
- Flexible build and run scripts

## Technology Stack

- **Angular**: 17.3.0
- **TypeScript**: ~5.4.2
- **Bootstrap**: 5.3.3
- **RxJS**: ~7.8.0
- **Zone.js**: ~0.14.3
- **Jasmine**: ~5.1.0
- **Karma**: ~6.4.0
- **Nginx**: Alpine (for Docker deployment)
- **Node.js**: 18+ (development)

## Prerequisites

- Node.js 18 or higher
- npm 9 or higher
- Angular CLI 17 or higher (optional, but recommended)
- Docker (optional, for containerized deployment)

## Getting Started

### Clone the Repository

```bash
git clone https://github.com/sekacorn/Hospital-Billing-Frontend.git
cd Hospital-Billing-Frontend
```

### Installation

```bash
# Navigate to the Angular app directory
cd billingapp

# Install dependencies
npm install

# Install Angular CLI globally (optional)
npm install -g @angular/cli
```

## Running the Application

### Option 1: Using the Build Script (Recommended)

The project includes a flexible build and run script with multiple options. Run from the project root:

```bash
# Show help and available options
./build-run.sh --help

# Run development server (default)
cd billingapp && ../build-run.sh

# Skip npm install (faster if dependencies are already installed)
cd billingapp && ../build-run.sh --skip-install

# Skip tests
cd billingapp && ../build-run.sh --skip-tests

# Build for production
cd billingapp && ../build-run.sh --prod --skip-tests

# Combined options
cd billingapp && ../build-run.sh --skip-install --skip-tests
```

### Option 2: Using npm Scripts Directly

```bash
# Navigate to the app directory
cd billingapp

# Development server
npm start

# The app will be available at http://localhost:4200
```

### Option 3: Using Docker

```bash
# Build and run using the build script (from project root)
./build-run.sh --docker

# Or manually
docker build -t hospital-billing-frontend .
docker run -d -p 80:80 --name hospital-billing-frontend hospital-billing-frontend

# Access at http://localhost
```

## Building for Production

```bash
# Navigate to the app directory
cd billingapp

# Build for production
npm run build

# Production build output will be in dist/billingapp/browser
```

## Testing

```bash
# Navigate to the app directory
cd billingapp

# Run unit tests
npm test

# Run tests in headless mode (CI/CD)
npm test -- --watch=false --browsers=ChromeHeadless

# Run tests with code coverage
npm test -- --code-coverage
```

## Project Structure

```
Hospital-Billing-Frontend/
├── billingapp/                    # Angular application
│   ├── src/
│   │   ├── app/
│   │   │   ├── components/       # Angular components
│   │   │   │   ├── billing/     # Billing management component
│   │   │   │   ├── diagnosis/   # Diagnosis management
│   │   │   │   ├── physician/   # Physician management
│   │   │   │   └── treatment/   # Treatment management
│   │   │   ├── models/          # TypeScript interfaces
│   │   │   │   ├── diagnosis.ts
│   │   │   │   ├── physician.ts
│   │   │   │   └── treatment.ts
│   │   │   ├── services/        # API services
│   │   │   │   └── billing.service.ts
│   │   │   └── app.component.ts # Root component
│   │   ├── assets/              # Static assets
│   │   ├── index.html           # Main HTML file
│   │   └── styles.css           # Global styles
│   ├── package.json             # npm dependencies
│   └── angular.json             # Angular configuration
├── Dockerfile                    # Docker configuration
├── nginx.conf                    # Nginx configuration
├── .dockerignore                # Docker ignore file
└── build-run.sh                 # Build and run script
```

## Configuration

### API Endpoint Configuration

The backend API URL is configured in the `BillingService`:

```typescript
// src/app/services/billing.service.ts
private apiUrl = 'http://localhost:8080/api';
```

To change the API endpoint, update this URL or use environment-specific configuration.

### Environment Configuration

Create environment files for different configurations:

```typescript
// src/environments/environment.ts (development)
export const environment = {
  production: false,
  apiUrl: 'http://localhost:8080/api'
};

// src/environments/environment.prod.ts (production)
export const environment = {
  production: true,
  apiUrl: 'https://your-api-domain.com/api'
};
```

Then update the service to use environment configuration:

```typescript
import { environment } from '../environments/environment';

private apiUrl = environment.apiUrl;
```

## Features Overview

### Diagnosis Management
- View all diagnoses with ICD-10 codes
- Create new diagnosis records
- Update existing diagnoses
- Delete diagnoses
- Search and filter capabilities

### Physician Management
- View physician directory
- Add new physicians
- Update physician information
- Remove physicians
- Track specialties and contact information

### Treatment Management
- View all available treatments
- Create treatment records
- Associate treatments with diagnoses
- Update treatment details
- Cost and duration tracking

## Docker Configuration

### Dockerfile

The project uses a multi-stage Docker build:
- **Stage 1**: Build the Angular application with Node.js
- **Stage 2**: Serve the built application with Nginx Alpine

### Nginx Configuration

The included `nginx.conf` provides:
- Optimized static file serving
- Gzip compression
- Cache control for assets
- Single Page Application (SPA) routing support

### Environment Variables

No environment variables are required for basic Docker deployment. The application uses the compiled configuration from build time.

## Build Script Options

The `build-run.sh` script supports:

| Option | Description |
|--------|-------------|
| `--skip-install` | Skip npm install step |
| `--skip-build` | Skip build step (only start dev server) |
| `--skip-tests` | Skip running tests |
| `--docker` | Build and run using Docker |
| `--prod` | Build for production |
| `-h, --help` | Display help message |

## Cleaning Build Artifacts

```bash
# From the billingapp directory
cd billingapp

# Remove compiled files
rm -rf dist .angular

# Remove all build artifacts and dependencies
rm -rf dist .angular node_modules
```

## Troubleshooting

### Port Already in Use

If port 4200 is already in use:
```bash
# Use a different port
ng serve --port 4201
```

### Backend Connection Issues

1. Ensure the backend is running on `http://localhost:8080`
2. Check CORS configuration in the backend
3. Verify API endpoint URL in `billing.service.ts`

### Build Errors

```bash
# Clear cache and reinstall dependencies
rm -rf node_modules package-lock.json
npm install

# Clear Angular cache
rm -rf .angular
```

### Test Failures

```bash
# Clear test cache
rm -rf .angular

# Run tests in debug mode
npm test -- --browsers=Chrome
```

## Development Guidelines

### Code Style

This project follows Angular style guidelines:
- Use TypeScript strict mode
- Follow component naming conventions
- Implement proper error handling
- Add comments for complex logic

### Component Structure

Each component should:
- Have a single responsibility
- Use standalone component architecture
- Implement proper lifecycle hooks
- Handle subscriptions properly (unsubscribe)

### Best Practices

1. **Error Handling**: Always handle HTTP errors gracefully
2. **Loading States**: Show loading indicators during API calls
3. **Validation**: Validate all form inputs
4. **Responsive Design**: Ensure mobile compatibility
5. **Accessibility**: Follow WCAG guidelines

## Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add/update tests
5. Ensure tests pass
6. Submit a pull request

## Scripts Reference

```json
{
  "start": "ng serve",                    // Start dev server
  "build": "ng build",                   // Build for production
  "watch": "ng build --watch",           // Build and watch for changes
  "test": "ng test"                      // Run unit tests
}
```

## Performance Optimization

The production build includes:
- Ahead-of-Time (AOT) compilation
- Tree shaking
- Minification
- Code splitting
- Lazy loading (when configured)



## Related Projects

- **Backend**: Hospital-Billing-Backend - Spring Boot REST API
