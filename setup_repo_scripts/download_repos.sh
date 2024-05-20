#!/bin/bash

Algo_SD_repo=(
    "List your repos here"
)

# Available algorithms (modify as needed)
algorithms=(
    "rsa"
    "dsa"
    "ed25519"
    "I have my own key"
)

# Default algorithm (change index for different default)
default_index=0
repo_root="{your_repo_root}"


# Get user input for algorithm
PS3="Select your ssh key algorithm (default: ${algorithms[$default_index]}): "
select chosen_algorithm in "${algorithms[@]}"; do
    break
done


if [[ ! " ${algorithms[@]} " =~ " $chosen_algorithm " ]]; then

    chosen_algorithm=${algorithms[$default_index]}
    printf "Selected algorithm not found, using default: $chosen_algorithm \n"
else
    printf "Selected algorithm verified: $chosen_algorithm \n"
fi

# Handle user's own key selection
if [[ "$chosen_algorithm" == "I have my own key" ]]; then
    printf "Since you selected 'I have my own key', the script won't generate a new key. \n"
    printf "**Please proceed with adding your existing key to the relevant repositories.** \n"

    for repo in "${Algo_SD_repo[@]}"; do
        printf "Start clonning repo: $repo ... \n"
        printf "\n"
        git clone "$repo_root"/"$repo".git
        printf "Done clonning repo: $repo \n"
    done

else
    # Generate SSH key based on chosen algorithm
    printf "Generating SSH key... \n"
    ssh-keygen -t "$chosen_algorithm" -f ~/.ssh/id_"${chosen_algorithm}" -N ""

    # Check if key generation was successful
    if [ $? -eq 0 ]; then
        printf "SSH key generated successfully! \n"

        # Get the public key
        public_key=$(cat ~/.ssh/id_$chosen_algorithm.pub)

        # Display the public key
        printf "**Public Key:** \n"
        printf "$public_key \n"
        printf ""

        # Ask user to confirm copying the key
        read -p "Have you copied the public key to the repo page (Y/N)? " confirm

        # Check user confirmation
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            for repo in "${Algo_SD_repo[@]}"; do
                printf "Start clonning repo: $repo ..."
                git clone "$repo_root"/"$repo".git
                printf "Done clonning repo: $repo"
            done

        else
            printf "Please copy the public key and add it to your server before continuing. \n"
            exit 1
        fi
    else
        printf "Error generating SSH key! \n"
        exit 1
    fi
fi
