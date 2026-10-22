#include <iostream>
#include <vector>
#include <algorithm>
#include <stdexcept>

int findMax(const std::vector<int>& arr) {
    if (arr.empty()) {
        throw std::invalid_argument("findMax: array is empty");
    }
    return *std::max_element(arr.begin(), arr.end());
}

int main() {
    int n;
    std::cout << "Enter number of elements: ";
    if (!(std::cin >> n) || n <= 0) {
        std::cerr << "Error: n must be a positive integer\n";
        return 1;
    }

    std::vector<int> arr(n);
    std::cout << "Enter numbers: ";
    for (int i = 0; i < n; i++) {
        if (!(std::cin >> arr[i])) {
            std::cerr << "Error: invalid input at position " << i << "\n";
            return 1;
        }
    }

    try {
        int result = findMax(arr);
        std::cout << "Max value: " << result << std::endl;
    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << "\n";
        return 1;
    }

    return 0;
}
