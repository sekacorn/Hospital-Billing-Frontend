#!/bin/bash

# Hospital Billing Frontend - Build and Run Script
# Usage: ./build-run.sh [OPTIONS]
#
# OPTIONS:
#   --skip-install    Skip npm install
#   --skip-build      Skip build step (only start dev server)
#   --skip-tests      Skip running tests
#   --docker          Build and run using Docker
#   --prod            Build for production
#   -h, --help        Show this help message

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default flags
SKIP_INSTALL=false
SKIP_BUILD=false
SKIP_TESTS=false
USE_DOCKER=false
PRODUCTION=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --skip-install)
            SKIP_INSTALL=true
            shift
            ;;
        --skip-build)
            SKIP_BUILD=true
            shift
            ;;
        --skip-tests)
            SKIP_TESTS=true
            shift
            ;;
        --docker)
            USE_DOCKER=true
            shift
            ;;
        --prod)
            PRODUCTION=true
            shift
            ;;
        -h|--help)
            echo "Hospital Billing Frontend - Build and Run Script"
            echo ""
            echo "Usage: ./build-run.sh [OPTIONS]"
            echo ""
            echo "OPTIONS:"
            echo "  --skip-install    Skip npm install"
            echo "  --skip-build      Skip build step (only start dev server)"
            echo "  --skip-tests      Skip running tests"
            echo "  --docker          Build and run using Docker"
            echo "  --prod            Build for production"
            echo "  -h, --help        Show this help message"
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Docker build and run
if [ "$USE_DOCKER" = true ]; then
    echo -e "${GREEN}Building and running with Docker...${NC}"

    echo -e "${YELLOW}Building Docker image...${NC}"
    docker build -t hospital-billing-frontend .

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Docker image built successfully${NC}"
        echo -e "${YELLOW}Running Docker container...${NC}"
        docker run -d -p 80:80 --name hospital-billing-frontend hospital-billing-frontend

        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Frontend is running at http://localhost${NC}"
        else
            echo -e "${RED}Failed to start Docker container${NC}"
            exit 1
        fi
    else
        echo -e "${RED}Docker build failed${NC}"
        exit 1
    fi
    exit 0
fi

# Install dependencies
if [ "$SKIP_INSTALL" = false ]; then
    echo -e "${YELLOW}Installing dependencies...${NC}"
    npm install

    if [ $? -ne 0 ]; then
        echo -e "${RED}npm install failed${NC}"
        exit 1
    fi
    echo -e "${GREEN}Dependencies installed successfully${NC}"
else
    echo -e "${YELLOW}Skipping npm install${NC}"
fi

# Run tests
if [ "$SKIP_TESTS" = false ]; then
    echo -e "${YELLOW}Running tests...${NC}"
    npm test -- --watch=false --browsers=ChromeHeadless

    if [ $? -ne 0 ]; then
        echo -e "${RED}Tests failed${NC}"
        exit 1
    fi
    echo -e "${GREEN}Tests passed successfully${NC}"
else
    echo -e "${YELLOW}Skipping tests${NC}"
fi

# Build or start dev server
if [ "$SKIP_BUILD" = false ]; then
    if [ "$PRODUCTION" = true ]; then
        echo -e "${YELLOW}Building for production...${NC}"
        npm run build -- --configuration production

        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Production build completed successfully${NC}"
            echo -e "${YELLOW}Build output is in dist/billingapp/browser${NC}"
        else
            echo -e "${RED}Production build failed${NC}"
            exit 1
        fi
    else
        echo -e "${YELLOW}Starting development server...${NC}"
        npm start
    fi
else
    echo -e "${YELLOW}Skipping build step${NC}"
fi
